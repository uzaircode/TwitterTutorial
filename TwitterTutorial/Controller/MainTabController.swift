//
//  MainTabController.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 28/09/2024.
//

import Foundation
import Firebase
import FirebaseAuth

class MainTabController: UITabBarController {
  
  // MARK: - Properties
  
  var user: User? {
    didSet {
      guard let nav = viewControllers?[0] as? UINavigationController else { return }
      guard let feed = nav.viewControllers.first as? FeedController else { return }
      
      feed.user = user
    }
  }
  
  private lazy var actionButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .white
    button.backgroundColor = .twitterBlue
    button.setImage(UIImage(named: "new_tweet"), for: .normal)
    button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //        logUserOut()
    view.backgroundColor = .twitterBlue
    authenticationUserAndConfigureUI()
  }
  
  // MARK: - API
  
  func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    UserService.shared.fetchUser(uid: uid) { user in
      self.user = user
    }
  }
  
  func authenticationUserAndConfigureUI() {
    if Auth.auth().currentUser == nil {
      DispatchQueue.main.async {
        let nav = UINavigationController(rootViewController: LoginController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false, completion: nil)
      }
    } else {
      configureViewController()
      configureUI()
      fetchUser()
    }
  }
  
  func logUserOut() {
    do {
      try Auth.auth().signOut()
    } catch let error {
      print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
    }
  }
  
  // MARK: - Selectors
  
  @objc func actionButtonTapped() {
    guard let user = user else { return }
    let controller = UploadTweetController(user: user)
    let nav = UINavigationController(rootViewController: controller)
    present(nav, animated: true, completion: nil)
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    view.addSubview(actionButton)
    actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.safeAreaLayoutGuide.rightAnchor,
                        paddingBottom: 64, paddingRight: 16,
                        width: 56, height: 56)
    actionButton.layer.cornerRadius = 56 / 2
  }
  
  func configureViewController() {
    let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
    let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
    
    let explore = ExploreController()
    let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
    
    let notifications = NotificationsController()
    let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notifications)
    
    let conversations = ConversationsController()
    let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
    
    tabBar.backgroundColor = .systemGray5
    viewControllers = [nav1, nav2, nav3, nav4]
  }
  
  func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: rootViewController)
    let appearance = UINavigationBarAppearance()
    
    nav.tabBarItem.image = image
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    nav.navigationBar.standardAppearance = appearance
    nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
    return nav
  }
}
