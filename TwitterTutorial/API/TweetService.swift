//
//  Untitled.swift
//  TwitterTutorial
//
//  Created by Nik Uzair on 07/10/2024.
//

import FirebaseAuth
import FirebaseDatabase

struct TweetService {
    static let shared = TweetService()
    
    public func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweet": 0,
                      "caption": caption] as [String : Any]
        REF_TWEET.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
   }
    public func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEET.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
}
