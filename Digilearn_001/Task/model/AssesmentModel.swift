//
//  AssesmentModel.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct AssesmentModel: Decodable {
    var assessmentQuiz: [AssessmentQuizModel]?

    enum CodingKeys: String, CodingKey {
        case assessmentQuiz = "assessment_quiz"
    }
}

struct AssessmentQuizModel: Decodable {
    var actionID: String?
    var topicID: String?
    var quizImage: String?
    var quizAudio: String?
    var title: String?
    var question: String?
    var content: String?
    var contentImage: String?
    var contentVideoLink: String?
    var category: String?
    var materialType: String?
    var quizType: String?
    var file: String?
    var pil1: String?
    var pil2: String?
    var pil3: String?
    var pil4: String?
    var gfStatus: String?
    var answer: String?

    enum CodingKeys: String, CodingKey {
        case actionID = "action_id"
        case topicID = "topic_id"
        case quizImage = "quiz_image"
        case quizAudio = "quiz_audio"
        case title, question, content
        case contentImage = "content_image"
        case contentVideoLink = "content_video_link"
        case category
        case materialType = "material_type"
        case quizType = "quiz_type"
        case file, pil1, pil2, pil3, pil4
        case gfStatus = "gf_status"
        case answer
    }
}
