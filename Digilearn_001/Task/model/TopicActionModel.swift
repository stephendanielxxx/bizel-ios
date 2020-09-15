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
    let topicName, topicFinish: String
    let topicDetailAction: [[String: String?]]

    enum CodingKeys: String, CodingKey {
        case topicName = "topic_name"
        case topicFinish = "topic_finish"
        case topicDetailAction = "topic_detail_action"
    }
}


