import Foundation

// mapping json keobjectnyaa

struct GroupModel: Decodable {
    let listGroup: [ListGroup]

    enum CodingKeys: String, CodingKey {
        case listGroup = "list_group"
    }
}

// MARK: - ListGroup
struct ListGroup: Decodable {
    let userID, groupID, groupName, groupAbout: String
    let groupImage: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case groupID = "group_id"
        case groupName = "group_name"
        case groupAbout = "group_about"
        case groupImage = "group_image"
    }
}

