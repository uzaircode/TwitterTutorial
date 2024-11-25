//
//  ProfileHeader.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 26/10/2024.
//

import UIKit
import SwiftUI

class ProfileHeader: UICollectionReusableView {
  
  // MARK: - Properties
  private let filterBar = ProfileFilterView()
  
  private let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .twitterBlue
    return view
  }()
  
  private lazy var backButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
    return button
  }()
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    iv.layer.borderColor = UIColor.white.cgColor
    iv.layer.borderWidth = 4
    return iv
  }()
  
  private let editProfileFollowButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Loading", for: .normal)
    button.layer.borderColor = UIColor.twitterBlue.cgColor
    button.layer.borderWidth = 1.25
    button.setTitleColor(.twitterBlue, for: .normal)
    button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
    return button
  }()
  
  private let fullNameLabel: UILabel = {
    let label = UILabel ()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.text = "Eddie Brock"
    return label
  }()
  
  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .lightGray
    label.text = "@venom"
    return label
  }()
  
  private let bioLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.numberOfLines = 3
    label.text = "This is a user bio that will span more than one line for test purposes"
    return label
  }()
  
  
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(containerView)
    containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
    
    addSubview(profileImageView)
    profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
    profileImageView.setDimensions(width: 80, height: 80)
    profileImageView.layer.cornerRadius = 80 / 2
    
    addSubview(editProfileFollowButton)
    editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 12)
    editProfileFollowButton.setDimensions(width: 100, height: 36)
    editProfileFollowButton.layer.cornerRadius = 36 / 2
    
    containerView.addSubview(backButton)
    backButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: 42, paddingLeft: 16)
    backButton.setDimensions(width: 30, height: 30)
    
    let userDetailsStack = UIStackView(arrangedSubviews: [fullNameLabel, usernameLabel, bioLabel])
    userDetailsStack.axis = .vertical
    userDetailsStack.distribution = .fillProportionally
    userDetailsStack.spacing = 4
    
    addSubview(userDetailsStack)
    userDetailsStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
    
    addSubview(filterBar)
    filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Selector
  @objc private func handleDismissal() {
    print("back button tapped...")
  }
  
  @objc private func handleEditProfileFollow() {
    print("edit button tapped...")
  }
}

// MARK: - SwiftUI Preview
struct ProfileHeader_Preview: PreviewProvider {
  static var previews: some View {
    ProfileHeaderPreviewWrapper()
      .previewLayout(.sizeThatFits)
  }
}

struct ProfileHeaderPreviewWrapper: UIViewRepresentable {
  func makeUIView(context: Context) -> ProfileHeader {
    return ProfileHeader()
  }
  
  func updateUIView(_ uiView: ProfileHeader, context: Context) {}
}
