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
    var image: UIImage?
    
    init(username: String, email: String, password: String, phoneNumber: String, image: UIImage? = nil) {
        self.username = username
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.image = image
    }
}
