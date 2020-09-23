//
//  EssayModel.swift
//  Digilearn_001
//
//  Created by Teke on 18/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct EssayModel: Decodable {
    let responseStatus: Bool
    let responseCode: Int
    let responseMessage: String
    let responseData: String
    let responseRequest: EssayRequest
    
    enum CodingKeys: String, CodingKey {
        case responseStatus = "success"
        case responseCode = "code"
        case responseMessage = "message"
        case responseData = "data"
        case responseRequest = "request"
    }
}

struct EssayRequest: Decodable {
    let userID, courseID, moduleID, topicID: String
    let actionID: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case courseID = "course_id"
        case moduleID = "module_id"
        case topicID = "topic_id"
        case actionID = "action_id"
    }
}
