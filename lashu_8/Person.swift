//
//  Person.swift
//  lashu_8
//
//  Created by Lasha Tavberidze on 24.11.24.
//

import UIKit
struct Person{
    var username: String
    var email: String
    var password: String
    var phoneNumber: String
    var image: Data?
    
    init(username: String, email: String, password: String, phoneNumber: String, image: Data? = nil) {
        self.username = username
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.image = image
    }
}
