//
//  User.swift
//  Expire
//
//  Created by iMac on 25/01/23.
//

import Foundation

class User {
    
    var uId: String?
    let firstName: String?
    let lastName: String?
    let userName: String?
    let emailId: String?
    let bio: String?
    let profilePicture: String?
    
    init(uId: String, firstName: String, lastName: String, userName: String, emailId: String, bio: String, profilePicture: String) {
        self.uId = uId
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.emailId = emailId
        self.bio = bio
        self.profilePicture = profilePicture
    }
    
}
 
