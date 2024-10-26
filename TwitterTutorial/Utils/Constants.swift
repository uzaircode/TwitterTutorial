//
//  Constants.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 29/09/2024.
//

import Firebase
import FirebaseStorage

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEET = DB_REF.child("tweets")
