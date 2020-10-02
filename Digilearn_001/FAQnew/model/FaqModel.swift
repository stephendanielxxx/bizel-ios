// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct FaqModel: Decodable {
    let faq: [FAQ]?

    enum CodingKeys: String, CodingKey {
        case faq = "faq:"
    }
}

// MARK: - FAQ
struct FAQ: Decodable {
    let faqID: String?
    let faqQuestion: String?
    let faqAnswer: String?
    let faqCategory: String?
    let faqStatus: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case faqID = "faq_id"
        case faqQuestion = "faq_question"
        case faqAnswer = "faq_answer"
        case faqCategory = "faq_category"
        case faqStatus = "faq_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

