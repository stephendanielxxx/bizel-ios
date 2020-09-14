//
//  ListTaskModel.swift
//  Digilearn_001
//
//  Created by Teke on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct ListTaskModel: Decodable {
    let courseByUid: [TaskModel]

    enum CodingKeys: String, CodingKey {
        case courseByUid = "course_by_uid"
    }
}

struct TaskModel: Decodable {
   let id, title, detail, author: String
   let image, totalModule, totalTopic, totalAction: String
   let totalFinished, createdAt, groupName, courseStart: String
   let courseEnd: String?

       enum CodingKeys: String, CodingKey {
           case id, title, detail, author, image
           case totalModule = "total_module"
           case totalTopic = "total_topic"
           case totalAction = "total_action"
           case totalFinished = "total_finished"
           case createdAt = "created_at"
           case groupName = "group_name"
           case courseStart = "course_start"
           case courseEnd = "course_end"
       }
}
