// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DetailModel: Decodable {
    let courseDetail: [CourseDetail]

    enum CodingKeys: String, CodingKey {
        case courseDetail = "course_detail:"
    }
}

// MARK: - CourseDetail
struct CourseDetail: Codable {
    let courseID, courseDescription: String

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case courseDescription = "course_description"
    }
}

