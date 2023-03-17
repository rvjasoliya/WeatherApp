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
import FirebaseFirestore
import CoreLocation

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
    
    var weatherCity: WeatherCity?
    var forecast: ForeCastModel?
    private let locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var userLat: Double = 0.0
    var userLong: Double = 0.0
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initialConfig()
    }
    
    // MARK: - Selectors
    
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
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            if currentLoc != nil{
                self.userLat = currentLoc!.coordinate.latitude
                self.userLong = currentLoc!.coordinate.longitude
            }
        }
        self.setupUI()
        self.setUserInfo()
        self.registerCell()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.getAppSettingsDataFromFirestoreDatabase()
    }
    
    // Register Cell
    func registerCell() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: DailyTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: DailyTableViewCell.cellIdentifier)
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
        self.labelCity.text = weatherCity?.name
        self.labelTemp.text = "\(weatherCity?.main?.temp ?? 0) ºC"

        self.labelWind.text = "\(weatherCity?.wind?.speed ?? 0) m/s"
        self.labelPressure.text = "\(weatherCity?.main?.pressure ?? 0) hPa"
        self.labelHumidity.text = "\(weatherCity?.main?.humidity ?? 0) %"
        self.labelVisibility.text = "\((weatherCity?.visibility ?? 0) / 1000) km" //Se retorna en metros lo convertimos a km

        if let weather = weatherCity?.weather?.first {
            self.labelWeather.text =  weather.description
            self.imageWeather.image = UIImage(named: weather.icon ?? "")
        }

    }
    
    // Get App Settings From Firestore Database
    func getAppSettingsDataFromFirestoreDatabase() {
        let db = Firestore.firestore()
        showLoading()
        db.collection("AppSettings").document("AppSettings").getDocument(completion: { snapshot, error in
            if let error = error {
                dissmissLoader()
                print(error.localizedDescription)
            } else {
                if let document = snapshot, document.exists {
                    if let data = document.data() {
                        let appSetting = AppSettingsModel(dictionary: (data as NSDictionary))
                        let ApiKey = (appSetting?.ApiKey ?? []).randomElement() ?? ""
                        self.weatherApi(appid: ApiKey, lat: self.userLat, lon: self.userLong)
                    }
                } else {
                    print("Document does not exist")
                }
            }
        })
    }
    
}

// MARK: - Extensions

// MARK: Api Call
extension HomeVC {
    
    func weatherApi(appid: String, lat: Double, lon: Double) {
        let url = "\(Apis.base_url)/weather?lat=\(lat)&lon=\(lon)&units=\(Apis.units)&appid=\(appid)"
        APIHelper.weatherApi(url: url) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
            } else {
                if let data = data as Any as? NSDictionary {
                    self.weatherCity = WeatherCity.init(dictionary: data)
                    self.setWeatherData()
                    self.forecastApi(appid: appid, lat: lat, lon: lon)
                }
            }
        }
    }
    
    func forecastApi(appid: String, lat: Double, lon: Double) {
        let url = "\(Apis.base_url)/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,current&units=\(Apis.units)&appid=\(appid)"
        APIHelper.forecastApi(url: url) { status, data, error in
            if !status {
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
            } else {
                if let data = data as Any as? NSDictionary {
                    self.forecast = ForeCastModel.init(dictionary: data)
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

// MARK: Collection View Setup
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let f = forecast { return f.hourly?.count ?? 0 } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionViewCell", for: indexPath) as! HourlyCollectionViewCell
        
        if let f = forecast {
            
            let hourly = f.hourly?[indexPath.row]
            
            cell.labelTemp.text = "\(Int(hourly?.temp ?? 0))º"
            cell.labelHour.text = Date(timeIntervalSince1970: Double(hourly?.dt ?? 0)).getNumberNameDay()
            if let weather = hourly?.weather?.first {
                cell.imageWeather.image = UIImage(named: weather.icon ?? "")
            }
        }
        
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
        if let d = forecast?.daily { return d.count } else { return 0 }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.cellIdentifier, for: indexPath) as! DailyTableViewCell

        if let d = forecast?.daily {

            let daily = d[indexPath.row]

            cell.dateLabel.text = Date(timeIntervalSince1970: Double(daily.dt ?? 0)).getMouthDay()
            cell.tempLabel.text =  "\(Int(daily.temp?.max ?? 0))º / \(Int(daily.temp?.min ?? 0))º"

            if let weather = daily.weather?.first {
                cell.imgView.image = UIImage(named: weather.icon ?? "")
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

// MARK: CLLocationManagerDelegate
extension HomeVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        if let location = manager.location {
            self.currentLoc = location
            self.userLat = location.coordinate.latitude
            self.userLong = location.coordinate.longitude
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}
