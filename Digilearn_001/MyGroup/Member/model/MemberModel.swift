// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MemberModel: Decodable {
    let membergroup: [Membergroup]

    enum CodingKeys: String, CodingKey {
        case membergroup = "membergroup:"
    }
}

// MARK: - Membergroup
struct Membergroup: Decodable {
    let memberID, memberStatus: String?
    let userFirstName, institutName, userLastName: String?

    enum CodingKeys: String, CodingKey {
        case memberID = "member_id"
        case memberStatus = "member_status"
        case userFirstName = "user_first_name"
        case institutName = "institut_name"
        case userLastName = "user_last_name"
    }
}

