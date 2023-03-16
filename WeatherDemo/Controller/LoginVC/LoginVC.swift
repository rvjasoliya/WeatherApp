//
//  LoginVC.swift
//  Expire
//
//  Created by iMac on 20/01/23.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var emailIdView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonView: UIView!
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initialConfig()
    }
    
    // MARK: - Selectors
    
    // Password Toggle Button Action
    @IBAction func passwordToggleButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        sender.setImage(UIImage(named: !self.passwordTextField.isSecureTextEntry ? "hide" : "show"), for: .normal)
    }
    
    // Login Button Action
    @IBAction func loginButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.emailIdTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            customAlertWithMessage(message: "Please Enter Your Email Address", okHandler: nil, viewController: self)
            return
        }
        if !isValidEmail(email: self.emailIdTextField.text ?? "") {
            customAlertWithMessage(message: "Please Enter Valid Email Address", okHandler: nil, viewController: self)
            return
        }
        if self.passwordTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            customAlertWithMessage(message: "Please Enter Your Password ", okHandler: nil, viewController: self)
            return
        }
        if !isValidPassword(mypassword: self.passwordTextField.text ?? "") {
            customAlertWithMessage(message: "Password should contain min of 8 characters and at least 1 lowercase, 1 symbol, 1 uppercase and 1 numeric value", okHandler: nil, viewController: self)
            return
        }
        let questionPostsRef = UserSystem.system.userRef
        let query = questionPostsRef.queryOrdered(byChild: "emailId").queryEqual(toValue: self.emailIdTextField.text ?? "")
        showLoading()
        query.observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                Auth.auth().signIn(withEmail: self.emailIdTextField.text ?? "", password: self.passwordTextField.text ?? "") { [weak self] authResult, error in
                    dissmissLoader()
                    guard let strongSelf = self else { return }
                    if let error = error {
                        customAlertWithMessage(message: "Please create an account. Click Register", okHandler: nil, viewController: strongSelf)
                        print(error.localizedDescription)
                    } else {
                        let newVC = strongSelf.storyboard?.instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
                        obj_AppDelegate.window?.rootViewController = newVC
                    }
                }
            } else {
                dissmissLoader()
                customAlertWithMessage(message: "Please create an account. Click Register", okHandler: nil, viewController: self)
            }
        })
    }
    
    // Register Button Action
    @IBAction func registerButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    // MARK: - Helper Functions
    
    // Initial Config
    func initialConfig() {
        self.setupUI()
    }
    
    // Setup UI
    func setupUI() {
        self.emailIdView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.passwordView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.loginButtonView.addShadowToView(shadow_color: UIColor(named: "Cal Poly Pomona Green")!, offset: CGSize(width: 0, height: 5), shadow_radius: 5, shadow_opacity: 0.3, corner_radius: 25, isOnlyBottomShadow: false)
        self.textFieldsSetup()
    }
    
    // TextFields Setup
    func textFieldsSetup() {
        self.emailIdTextField.attributedPlaceholder = NSAttributedString(
            string: "Email Id",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
        self.passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
    }
    
}
