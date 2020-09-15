//
//  ListCourseModel.swift
//  Digilearn_001
//
//  Created by Teke on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct ListCourseModel: Decodable {
    let courseImage: String
    let moduleDetail: [ModuleDetail]

    enum CodingKeys: String, CodingKey {
        case courseImage = "course_image"
        case moduleDetail = "module_detail"
    }
}

// MARK: - ModuleDetail
struct ModuleDetail: Decodable {
    let moduleID, moduleName, moduleDesc, moduleImage: String
    let moduleFinish, totalTopic, courseAuthor, courseAccess: String

    enum CodingKeys: String, CodingKey {
        case moduleID = "module_id"
        case moduleName = "module_name"
        case moduleDesc = "module_desc"
        case moduleImage = "module_image"
        case moduleFinish = "module_finish"
        case totalTopic = "total_topic"
        case courseAuthor = "course_author"
        case courseAccess = "course_access"
    }
}
