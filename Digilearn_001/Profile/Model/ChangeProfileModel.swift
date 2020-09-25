//
//  ChangeProfileModel.swift
//  Digilearn_001
//
//  Created by Teke on 25/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct ChangeProfileModel: Decodable {
    let info: String
    let message: String
    enum CodingKeys: String, CodingKey {
        case info = "Info"
        case message = "Message:"
    }
}
