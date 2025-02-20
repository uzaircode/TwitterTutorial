//
//  CaptionTextView.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 07/10/2024.
//

import UIKit

class CaptionTextView: UITextView {
  
  //MARK: - Properties
  let placeholderLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .darkGray
    label.text = "What's Happening?"
    return label
  }()
  
  //MARK: - Lifecycle
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    backgroundColor = .white
    font = UIFont.systemFont(ofSize: 16)
    isScrollEnabled = false
    heightAnchor.constraint(equalToConstant: 300).isActive = true
    
    addSubview(placeholderLabel)
    placeholderLabel.anchor(top: topAnchor,
                            left: leftAnchor,
                            paddingTop: 8,
                            paddingLeft: 4)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange),
                                           name: UITextView.textDidChangeNotification, object: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Selectors
  
  @objc func handleTextInputChange() {
    print("DEBUG: Hide and show placeholder...")
    placeholderLabel.isHidden = !text.isEmpty
  }
  //MARK: - Helpers
}
