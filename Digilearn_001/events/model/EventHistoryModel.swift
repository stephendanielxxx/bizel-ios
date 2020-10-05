//
//  EventHistoryModel.swift
//  Digilearn_001
//
//  Created by Teke on 05/10/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct EventHistoryModel: Codable {
    let registeredEvent: [RegisteredEvent]

    enum CodingKeys: String, CodingKey {
        case registeredEvent = "registered_event"
    }
}

struct RegisteredEvent: Codable {
    let uid, name, desc, date: String?
    let place, img: String?
}
