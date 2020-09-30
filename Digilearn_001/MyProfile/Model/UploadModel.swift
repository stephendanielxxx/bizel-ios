//
//  UploadImageModel.swift
//  Digilearn_001
//
//  Created by Teke on 30/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct UploadModel: Decodable{
    let code: String!
    let new_image: String?
    let message: String?
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case new_image = "new_image"
        case message = "message"
    }
}
