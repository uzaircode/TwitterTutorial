//
//  uploadTweetController.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 06/10/2024.
//


import UIKit

class UploadTweetController: UIViewController {
  
  //MARK: - Properties
  private let user: User
  
  private lazy var actionButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .twitterBlue
    button.setTitle("Tweet", for:  .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitleColor(.white, for: .normal)
    button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
    button.layer.cornerRadius = 32 / 2
    button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
    
    return button
  }()
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.setDimensions(width: 48, height: 48)
    iv.layer.cornerRadius = 48 / 2
    iv.backgroundColor = .twitterBlue
    return iv
  }()
  
  private let captionTextView = CaptionTextView()
  
  //MARK: - Lifecycle
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    print("DEBUG: User is \(user.username)")
  }
  
  //MARK: - Selector
  
  @objc func handleCancel() {
    dismiss(animated: true, completion: nil)
    
  }
  
  @objc func handleUploadTweet() {
    guard let caption = captionTextView.text else { return }
    TweetService.shared.uploadTweet(caption: caption) { (error, ref) in
      if let error = error {
        print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
        return
      }
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  //MARK: - API
  
  
  //MARK: - Helper
  func configureUI() {
    view.backgroundColor = .white
    configureNavigationBar()
    
    let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
    stack.axis = .horizontal
    stack.spacing = 12
    
    view.addSubview(stack)
    stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
    profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
  }
  
  func configureNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white 
    appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
  }
}
