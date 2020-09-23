// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AchievementModel: Decodable {
    let achievement: [Achievement]
}

// MARK: - Achievement
struct Achievement: Decodable {
    let topicID, courseName, actionName, topicName: String
    let nickname: String

    enum CodingKeys: String, CodingKey {
        case topicID = "topic_id"
        case courseName = "course_name"
        case actionName = "action_name"
        case topicName = "topic_name"
        case nickname
    }
}

