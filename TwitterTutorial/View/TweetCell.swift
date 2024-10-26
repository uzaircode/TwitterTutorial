//
//  TweetCell.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 09/10/2024.
//

import UIKit

protocol TweetCellDelegate: AnyObject {
    func handleProfileImageTapped()
}

class TweetCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    weak var delegate: TweetCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "Some test caption"
        return label
    }()
    
    private let infolabel = UILabel()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 8)
        bringSubviewToFront(profileImageView)

        let stack = UIStackView(arrangedSubviews: [infolabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor,
                             right: rightAnchor, height: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleProfileImageTapped(){
        delegate?.handleProfileImageTapped()
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configure() {
       print("DEBUG: Did set tweet in cell...")
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)

        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        captionLabel.text = tweet.caption
        infolabel.attributedText = viewModel.userInfoText
    }
}
