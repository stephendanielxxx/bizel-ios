// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AnnouncementModel: Decodable {
    let news: [News]
}

// MARK: - News
struct News: Decodable {
    let newsID, title, isi, timePosted: String
    let announcementImage: String

    enum CodingKeys: String, CodingKey {
        case newsID = "news_id"
        case title, isi
        case timePosted = "time_posted"
        case announcementImage = "announcement_image"
    }
}

