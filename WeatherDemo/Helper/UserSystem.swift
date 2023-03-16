//
//  UserSystem.swift
//  Expire
//
//  Created by iMac on 20/01/23.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class UserSystem {
    
    static let system = UserSystem()
    
    let userRef = Database.database().reference().child("users")
    
    var currentUserId: String {
        guard let id = Auth.auth().currentUser?.uid else { return "" }
        return id
    }
    
    var currentUserRef: DatabaseReference {
        if let id = Auth.auth().currentUser?.uid {
            return userRef.child(id)
        } else {
            return DatabaseReference()
        }
    }
    
    func logoutAccount() {
        self.currentUserRef.removeAllObservers()
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func getUserDetails(_ userID: String, completion: @escaping (User) -> Void) {
        userRef.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                let firstName = snapshot.childSnapshot(forPath: "firstName").value as? String ?? ""
                let lastName = snapshot.childSnapshot(forPath: "lastName").value as? String ?? ""
                let userName = snapshot.childSnapshot(forPath: "userName").value as? String ?? ""
                let emailId = snapshot.childSnapshot(forPath: "emailId").value as? String ?? ""
                let bio = snapshot.childSnapshot(forPath: "bio").value as? String ?? ""
                let profilePicture = snapshot.childSnapshot(forPath: "profilePicture").value as? String ?? ""
                completion(User(uId: snapshot.key, firstName: firstName, lastName: lastName, userName: userName, emailId: emailId, bio: bio, profilePicture: profilePicture))
            }
        })
    }
    
}
