//
//  GetLibraryModel.swift
//  Digilearn_001
//
//  Created by Teke on 23/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct GetLibraryModel: Decodable {
    let library: [LibraryModel]

    enum CodingKeys: String, CodingKey {
        case library = "library:"
    }
}

// MARK: - Library
struct LibraryModel: Decodable {
    let totalModule, courseID, courseImage, courseName: String
    let institutName, totalTopic, totalAction: String

    enum CodingKeys: String, CodingKey {
        case totalModule = "Total_Module"
        case courseID = "course_id"
        case courseImage = "course_image"
        case courseName = "course_name"
        case institutName = "institut_name"
        case totalTopic = "Total_Topic"
        case totalAction = "Total_Action"
    }
}
