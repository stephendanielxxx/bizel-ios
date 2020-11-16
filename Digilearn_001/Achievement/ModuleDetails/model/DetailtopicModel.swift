// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DetailtopicModel: Decodable {
    let moduleDetailAchievement: [ModuleDetailAchivement]

    enum CodingKeys: String, CodingKey {
        case moduleDetailAchievement = "module_detail:"
    }
}

// MARK: - ModuleDetail
struct ModuleDetailAchivement: Decodable {
    let moduleID, moduleDescription: String

    enum CodingKeys: String, CodingKey {
        case moduleID = "module_id"
        case moduleDescription = "module_description"
    }
}
