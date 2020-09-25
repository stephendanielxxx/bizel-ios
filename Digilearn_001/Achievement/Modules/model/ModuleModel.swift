// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ModuleModel: Decodable {
    let courseListModule: [CourseListModule]

    enum CodingKeys: String, CodingKey {
        case courseListModule = "course_list_module:"
    }
}

// MARK: - CourseListModule
struct CourseListModule: Decodable {
    let courseID, moduleID, moduleImage, moduleDownload: String
    let moduleName: String

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case moduleID = "module_id"
        case moduleImage = "module_image"
        case moduleDownload = "module_download"
        case moduleName = "module_name"
    }
}

