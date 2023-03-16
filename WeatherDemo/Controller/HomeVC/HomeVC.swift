//
//  HomeVC.swift
//  Expire
//
//  Created by iMac on 20/01/23.
//

import UIKit
import FirebaseAuth
import SDWebImage
import Toast_Swift
import Alamofire

class HomeVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userDetailsView: UIView!
    @IBOutlet weak var userImageShadowView: UIView!
    @IBOutlet weak var userImageBackgroundView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var userEmailIdLabel: UILabel!
    
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelVisibility: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var weatherData: WeatherModel?
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initialConfig()
    }
    
    // MARK: - Selectors
    
    // Menu Button Action
    @IBAction func menuButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
       
    }
    
    // LogOut Button Action
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "LogOut", style: .destructive, handler: { action in
            DispatchQueue.main.async {
                UserSystem.system.logoutAccount()
                if Auth.auth().currentUser == nil {
                    let newVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
                    obj_AppDelegate.window?.rootViewController = newVC
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    
    // Initial Config
    func initialConfig() {
        self.setupUI()
        self.setUserInfo()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        
        self.forecastApi()
    }
    
    // Setup UI
    func setupUI() {
        self.userDetailsView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 4, shadow_opacity: 0.2, corner_radius: 10, isOnlyBottomShadow: false)
        self.userImageBackgroundView.layer.cornerRadius = 10
        self.userImageBackgroundView.clipsToBounds = true
        self.userImageShadowView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
    }
    
    // Set User Info
    func setUserInfo() -> Void {
        if UserSystem.system.currentUserId == "" {
            DispatchQueue.main.async {
                UserSystem.system.logoutAccount()
                if Auth.auth().currentUser == nil {
                    let newVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
                    obj_AppDelegate.window?.rootViewController = newVC
                }
            }
        } else {
            UserSystem.system.getUserDetails(UserSystem.system.currentUserId, completion: { user in
                if let url = URL(string: user.profilePicture ?? "") {
                    self.userImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "userPlaceHolder"))
                    self.userFullNameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
                    self.userNameLabel.text = user.userName
                    self.userBioLabel.text = user.bio
                    self.userEmailIdLabel.text = user.emailId
                }
            })
        }
    }
    
    func setWeatherData() {
        self.labelCity.text = weatherData?.location?.name
        self.labelTemp.text = "\(weatherData?.current?.temp_c ?? 0) ºC"
        self.labelWind.text = "\(weatherData?.current?.wind_mph ?? 0) mph"
        self.labelPressure.text = "\(weatherData?.current?.pressure_mb ?? 0) hPa"
        
        self.labelHumidity.text = "\(weatherData?.current?.humidity ?? 0) %"
        self.labelVisibility.text = "\(weatherData?.current?.vis_km ?? 0 ) km"
        self.labelWeather.text =  weatherData?.current?.condition?.text
//        print(weatherData?.current?.condition?.icon?.split(separator: "/").last ?? "")

    }
    
}

// MARK: - Extensions

// MARK: Api Call
extension HomeVC {
    
    // Forecast Api
    func forecastApi() {
        let param: Parameters = [
            "q": "Surat"
        ]
        APIHelper.forecastApi(parameters: param) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
            } else {
                if let data = data as Any as? NSDictionary {
                    self.weatherData = WeatherModel.init(dictionary: data)
                    self.setWeatherData()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

// MARK: Collection View Setup
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherData?.forecast?.forecastday?.first?.hour?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionViewCell", for: indexPath) as! HourlyCollectionViewCell
        let rowPath = self.weatherData?.forecast?.forecastday?.first?.hour?[indexPath.row]
        cell.labelHour.text = "\(rowPath?.time?.split(separator: " ").last ?? "")"
        cell.labelTemp.text = "\(rowPath?.temp_c ?? 0)º"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.bounds.height / 2, height: collectionView.bounds.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: TableView Setup
extension HomeVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
//        if let d = dailyWeather { return d.count } else { return 0 }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewCell", for: indexPath)

//        if let d = dailyWeather {
//
//            let daily = d[indexPath.row]
//
//            cell.textLabel?.text = Date(timeIntervalSince1970: Double(daily.dt)).getMouthDay()
//            cell.detailTextLabel?.text =  "\(Int(daily.temp.max))º / \(Int(daily.temp.min))º"
//
//            if let weather = daily.weather.first {
//                cell.imageView?.image = UIImage(named: weather.icon)
//            }
//        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
