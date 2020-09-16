//
//  TopicActionModel.swift
//  Digilearn_001
//
//  Created by Teke on 15/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct TopicActionModel: Decodable {
    let topicDetail: [TopicDetail]

    enum CodingKeys: String, CodingKey {
        case topicDetail = "topic_detail"
    }
}

// MARK: - TopicDetail
struct TopicDetail: Decodable {
    let topicName, topicFinish: String?
    let topicDetailAction: [TopicDetailAction]?

    enum CodingKeys: String, CodingKey {
        case topicName = "topic_name"
        case topicFinish = "topic_finish"
        case topicDetailAction = "topic_detail_action"
    }
}

struct TopicDetailAction: Decodable {
    let sakral, moduleID, moduleName, topicID: String?
    let actionID, actionOrder, actionName, actionMaterialImage: String?
    let actionQuizImage, actionTipe: String?
    let actionMaterialTipe: String?
    let topicName, finished, topicAccess, nextAction: String?
    let nextTopicID: String?

    enum CodingKeys: String, CodingKey {
        case sakral
        case moduleID = "module_id"
        case moduleName = "module_name"
        case topicID = "topic_id"
        case actionID = "action_id"
        case actionOrder = "action_order"
        case actionName = "action_name"
        case actionMaterialImage = "action_material_image"
        case actionQuizImage = "action_quiz_image"
        case actionTipe = "action_tipe"
        case actionMaterialTipe = "action_material_tipe"
        case topicName = "topic_name"
        case finished
        case topicAccess = "topic_access"
        case nextAction = "next_action"
        case nextTopicID = "next_topic_id"
    }
}
