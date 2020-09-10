//
//  RegisterEventModel.swift
//  Digilearn_001
//
//  Created by Teke on 10/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct RegisterEventModel: Decodable {
    let success: Bool
    let code, message: String
    let request: Request
}

struct Request: Decodable {
    let uid, event_id, event_name: String

    enum CodingKeys: String, CodingKey {
        case uid
        case event_id
        case event_name
    }
}
