// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AchieveModel: Decodable {
    let library: [Library]

    enum CodingKeys: String, CodingKey {
        case library = "library:"
    }
}

// MARK: - Library
struct Library: Decodable {
    let courseID, moduleDownload: String
    let courseName: String?
    let courseImage: String?
    let institutName: String

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case courseImage = "course_image"
        case moduleDownload = "module_download"
        case courseName = "course_name"
        case institutName = "institut_name"
    }
}
