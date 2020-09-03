//
//  LoginModel.swift
//  Digilearn_001
//
//  Created by Teke on 03/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct LoginModel: Decodable {
    let code, message: String
    let user: [User]?
}

// MARK: - User
struct User: Decodable {
    let id, firstName, lastName, nickname: String
    let phone, email, photo, institution: String
    let position: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname, phone, email, photo, institution, position
    }
}
