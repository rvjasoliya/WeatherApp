//
//  RegisterVC.swift
//  Expire
//
//  Created by iMac on 19/01/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RegisterVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userImageShadowView: UIView!
    @IBOutlet weak var userImageBackgroundView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailIdView: UIView!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var bioView: UIView!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButtonView: UIView!
    
    // MARK: - Properties
    
    var imagePicker = UIImagePickerController()
    var userImage: UIImage? = nil
    var mobileCode = ""
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initialConfig()
    }
    
    // MARK: - Selectors
    
    // User Image Button Action
    @IBAction func userImageButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            self.openPhotos()
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Password Toggle Button Action
    @IBAction func passwordToggleButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender.tag == 1001 {
            self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
            sender.setImage(UIImage(named: !self.passwordTextField.isSecureTextEntry ? "hide" : "show"), for: .normal)
        } else {
            self.confirmPasswordTextField.isSecureTextEntry = !self.confirmPasswordTextField.isSecureTextEntry
            sender.setImage(UIImage(named:  !self.confirmPasswordTextField.isSecureTextEntry ? "hide" : "show"), for: .normal)
        }
    }
    
    // Register Button Action
    @IBAction func registerButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.userImage == nil {
            customAlertWithMessage(message: "Please Upload Your Profile Picture😎", okHandler: nil, viewController: self)
            return
        }
        if self.firstNameTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            customAlertWithMessage(message: "Please Enter Your First Name", okHandler: nil, viewController: self)
            return
        }
        if self.lastNameTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            customAlertWithMessage(message: "Please Enter Your Last Name", okHandler: nil, viewController: self)
            return
        }
        if self.userNameTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            customAlertWithMessage(message: "Please Enter Your User Name", okHandler: nil, viewController: self)
            return
        }
        if self.emailIdTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            customAlertWithMessage(message: "Please Enter Your Email Address", okHandler: nil, viewController: self)
            return
        }
        if !isValidEmail(email: self.emailIdTextField.text ?? "") {
            customAlertWithMessage(message: "Please Enter Valid Email Address", okHandler: nil, viewController: self)
            return
        }
        if self.bioTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            customAlertWithMessage(message: "Please Enter Your Mobile Number", okHandler: nil, viewController: self)
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
        if self.confirmPasswordTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            customAlertWithMessage(message: "Please Enter Your Confirm Password", okHandler: nil, viewController: self)
            return
        }
        if self.confirmPasswordTextField.text != self.passwordTextField.text {
            customAlertWithMessage(message: "Password and Confirm Password didn't match", okHandler: nil, viewController: self)
            return
        }
        showLoading()
        let questionPostsRef = UserSystem.system.userRef
        let query = questionPostsRef.queryOrdered(byChild: "userName").queryEqual(toValue: self.userNameTextField.text ?? "")
        query.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                for child in snapshot.children {
                    let childSnap = child as! DataSnapshot
                    let dict = childSnap.value as! [String: Any]
                    let cat = dict["userName"] as! String
                    print(childSnap.key, cat)
                }
                dissmissLoader()
                customAlertWithMessage(message: "This User Name is already taken. Please Register with diffrent User Name... ", okHandler: nil, viewController: self)
                return
            } else {
                let questionPostsRef = UserSystem.system.userRef
                let query = questionPostsRef.queryOrdered(byChild: "emailId").queryEqual(toValue: self.emailIdTextField.text ?? "")
                query.observeSingleEvent(of: .value, with: { snapshot in
                    if snapshot.exists() {
                        for child in snapshot.children {
                            let childSnap = child as! DataSnapshot
                            let dict = childSnap.value as! [String: Any]
                            let cat = dict["emailId"] as! String
                            print(childSnap.key, cat)
                        }
                        dissmissLoader()
                        customAlertWithMessage(message: "There's already an account with this Email Address.😎", okHandler: nil, viewController: self)
                    } else {
                        Auth.auth().createUser(withEmail: self.emailIdTextField.text ?? "", password: self.passwordTextField.text ?? "") { [weak self] authResult, error in
                            guard let strongSelf = self else { return }
                            if let error = error {
                                dissmissLoader()
                                print(error.localizedDescription)
                                return
                            } else {
                                let user = [
                                    "firstName": strongSelf.firstNameTextField.text ?? "",
                                    "lastName": strongSelf.lastNameTextField.text ?? "",
                                    "userName" : strongSelf.userNameTextField.text ?? "",
                                    "emailId": strongSelf.emailIdTextField.text ?? "",
                                    "bio": strongSelf.bioTextField.text ?? "",
                                    "profilePicture": ""
                                ] as Any as! [String : AnyObject]
                                UserSystem.system.currentUserRef.updateChildValues(user)
                                let storageRef = Storage.storage().reference(withPath: "users/\(authResult?.user.uid ?? "")")
                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                guard let imageData = strongSelf.userImage?.jpegData(compressionQuality: 0.4) else { return }
                                storageRef.putData(imageData, metadata: nil) { (metaData, error) in
                                    storageRef.downloadURL(completion: { (url, error) in
                                        changeRequest?.photoURL = url
                                        changeRequest?.displayName = (strongSelf.firstNameTextField.text ?? "") + " " + (strongSelf.lastNameTextField.text ?? "")
                                        UserSystem.system.currentUserRef.child("profilePicture").setValue(url?.absoluteString)
                                        changeRequest?.commitChanges(completion: { (error) in
                                            if let error = error {
                                                dissmissLoader()
                                                print(error.localizedDescription)
                                            } else {
                                                dissmissLoader()
                                                customAlertWithMessage(message: "User Register Successfully...", okHandler: { action in
                                                    let newVC = strongSelf.storyboard?.instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
                                                    obj_AppDelegate.window?.rootViewController = newVC
                                                }, viewController: strongSelf)
                                            }
                                        })
                                    })
                                }
                            }
                        }
                    }
                })
            }
        }
    }
    
    // Login Button Action
    @IBAction func loginButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    
    // Initial Config
    func initialConfig() {
        self.setupUI()
        self.imagePicker.delegate = self
    }
    
    // Setup UI
    func setupUI() {
        self.userImageBackgroundView.layer.cornerRadius = 10
        self.userImageBackgroundView.clipsToBounds = true
        self.userImageShadowView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.firstNameView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.lastNameView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.userNameView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.emailIdView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.bioView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.passwordView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.confirmPasswordView.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 0, height: 0), shadow_radius: 5, shadow_opacity: 0.1, corner_radius: 10, isOnlyBottomShadow: false)
        self.registerButtonView.addShadowToView(shadow_color: UIColor(named: "Cal Poly Pomona Green")!, offset: CGSize(width: 0, height: 5), shadow_radius: 5, shadow_opacity: 0.3, corner_radius: 25, isOnlyBottomShadow: false)
        self.textFieldsSetup()
    }
    
    // TextFields Setup
    func textFieldsSetup() {
        self.firstNameTextField.attributedPlaceholder = NSAttributedString(
            string: "First Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
        self.lastNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Last Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
        self.userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "User Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
        self.emailIdTextField.attributedPlaceholder = NSAttributedString(
            string: "Email Id",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
        self.bioTextField.attributedPlaceholder = NSAttributedString(
            string: "Bio",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
        self.passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
        self.confirmPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "Confirm Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Davy's Grey") as Any]
        )
    }
    
    // Open Camera
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "Camera Not Supported", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Open Image Gallary
    func openPhotos() {
        self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.imagePicker.allowsEditing = false
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
}

// MARK: - Extensions

// MARK: UIImagePickerControllerDelegate & UINavigationControllerDelegate Methods
extension RegisterVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        self.userImage = image
        self.userImageView.image = image
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
