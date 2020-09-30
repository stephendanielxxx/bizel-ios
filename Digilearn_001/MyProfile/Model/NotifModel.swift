//
//  NotificationModel.swift
//  Digilearn_001
//
//  Created by Teke on 30/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct NotifModel: Decodable {
    let status: String!
    let code: String!
    let message: String?
}
