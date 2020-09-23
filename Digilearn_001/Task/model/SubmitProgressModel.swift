//
//  SubmitProgressModel.swift
//  Digilearn_001
//
//  Created by Teke on 18/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

// MARK: - TopicDetailAction
struct SubmitProgressModel: Decodable {
    let success: Bool
    let code: Int
    let message: String
    let data: Bool?
    let request: SubmitProgressRequest
}

// MARK: - Request
struct SubmitProgressRequest: Decodable {
    let uid, courseID, moduleID, topicID: String
    let actionID, answer: String

    enum CodingKeys: String, CodingKey {
        case uid
        case courseID = "course_id"
        case moduleID = "module_id"
        case topicID = "topic_id"
        case actionID = "action_id"
        case answer
    }
}
