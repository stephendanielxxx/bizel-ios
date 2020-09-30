// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct FaqcatModel: Decodable {
    let faqCat: [FAQCat]

    enum CodingKeys: String, CodingKey {
        case faqCat = "faq_cat:"
    }
}

// MARK: - FAQCat
struct FAQCat: Decodable {
    let faqCategory, faqCatName: String

    enum CodingKeys: String, CodingKey {
        case faqCategory = "faq_category"
        case faqCatName = "faq_cat_name"
    }
}

