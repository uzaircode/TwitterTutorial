//
//  RegistrationController.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 28/09/2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationController: UIViewController {
  
  // MARK: - Properties
  
  private let imagePicker = UIImagePickerController()
  private var profileImage: UIImage?
  
  private let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
    return button
  }()
  
  private lazy var emailContainerView: UIView = {
    let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
    let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
    return view
  }()
  
  private lazy var passwordContainerView: UIView = {
    let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
    let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
    return view
  }()
  
  private lazy var fullNameContainerView: UIView = {
    let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
    let view = Utilities().inputContainerView(withImage: image, textField: fullNameTextField)
    return view
  }()
  
  private lazy var usernameContainerView: UIView = {
    let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
    let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
    return view
  }()
  
  private let emailTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Email")
    tf.textColor = .white
    return tf
  }()
  
  private let passwordTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let fullNameTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Full Name")
    tf.textColor = .white
    return tf
  }()
  
  private let usernameTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Username")
    tf.textColor = .white
    return tf
  }()
  
  private let registrationButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.setTitleColor(.twitterBlue, for: .normal)
    button.backgroundColor = .white
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
    return button
  }()
  
  private let alreadyHaveAccountButton: UIButton = {
    let button = Utilities().attributedButton("Already have an account", " Sign In")
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Selectors
  
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func handleAddProfilePhoto() {
    present(imagePicker, animated: true, completion: nil)
  }
  
  @objc func handleRegistration() {
    guard let profileImage = profileImage else {
      print("DEBUG: Please select a profile image...")
      return
    }
    guard let email = emailTextField.text, !email.isEmpty,
          let password = passwordTextField.text, !password.isEmpty,
          let fullname = fullNameTextField.text, !fullname.isEmpty,
          let username = usernameTextField.text, !username.isEmpty else {
      print("DEBUG: Please fill in all fields.")
      return
    }
    let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
    
    AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
      let scenes = UIApplication.shared.connectedScenes
      let windowScene = scenes.first as? UIWindowScene
      guard let window = windowScene?.windows.first(where: { $0.isKeyWindow }) else { return }
      guard let tab = window.rootViewController as? MainTabController else { return }
      
      tab.authenticationUserAndConfigureUI()
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  // MARK: - Helpers
  func configureUI() {
    view.backgroundColor = .twitterBlue
    
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    view.addSubview(plusPhotoButton)
    plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
    plusPhotoButton.setDimensions(width: 128, height: 128)
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                               passwordContainerView,
                                               fullNameContainerView,
                                               usernameContainerView,
                                               registrationButton])
    stack.axis = .vertical
    stack.spacing = 20
    stack.distribution = .fillEqually
    
    view.addSubview(stack)
    stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,
                 right: view.rightAnchor, paddingTop: 32, paddingLeft: 16, paddingRight: 16)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                    right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
  }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let profileImage = info[.editedImage] as? UIImage else { return }
    self.profileImage = profileImage
    
    plusPhotoButton.layer.cornerRadius = 128 / 2
    plusPhotoButton.layer.masksToBounds = true
    plusPhotoButton.imageView?.contentMode = .scaleAspectFill
    plusPhotoButton.imageView?.clipsToBounds = true
    plusPhotoButton.layer.borderColor = UIColor.white.cgColor
    plusPhotoButton.layer.borderWidth = 3
    
    self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
    
    dismiss(animated: true, completion: nil)
  }
}

