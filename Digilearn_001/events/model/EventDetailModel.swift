//
//  EventDetailModel.swift
//  Digilearn_001
//
//  Created by Teke on 10/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct EventDetailModel: Decodable {
    let onsite: [OnsiteDetail]
}

// MARK: - Onsite
struct OnsiteDetail: Decodable {
    let event_id, title, desc: String
    let image: String
    let place: String

    enum CodingKeys: String, CodingKey {
        case event_id
        case title, image, desc, place
    }
}
