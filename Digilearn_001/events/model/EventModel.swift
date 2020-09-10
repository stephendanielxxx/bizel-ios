//
//  EventModel.swift
//  Digilearn_001
//
//  Created by Teke on 07/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct EventModel: Decodable {
    let onsite: [Onsite]
}

// MARK: - Onsite
struct Onsite: Decodable {
    let id, title, image, date: String
    let place: String
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, image, date, place
        case createdAt
    }
}
