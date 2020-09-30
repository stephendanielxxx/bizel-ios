//
//  CourseDetailModel.swift
//  Digilearn_001
//
//  Created by Teke on 30/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct CourseDetailModel: Decodable {
    let course_detail: [CourseDetail]
    enum CodingKeys: String, CodingKey {
          case course_detail = "course_detail:"
      }
}

struct CourseDetail: Decodable {
    let course_id: String
    let course_description: String?
}
