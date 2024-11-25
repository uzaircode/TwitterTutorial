//
//  ExploreController.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 28/09/2024.
//

import UIKit

class ExploreController: UIViewController {
  
  // MARK: - Properties
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    view.backgroundColor = .white
    navigationItem.title = "Explore"
  }
}
