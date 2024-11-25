//
//  UserService.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 05/10/2024.
//

import FirebaseAuth

struct UserService {
  static let shared = UserService()
  
  func fetchUser(uid: String, completion: @escaping(User) -> Void) {
    
    REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
      guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
      print("DEBUG: Dictionary is \(dictionary)")
      
      let user = User(uid: uid, dictionary: dictionary)
      completion(user)
    }
  }
}
