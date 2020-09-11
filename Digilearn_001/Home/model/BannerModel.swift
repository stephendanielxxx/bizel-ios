//
//  BannerModel.swift
//  Digilearn_001
//
//  Created by Teke on 11/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct BannerModel: Decodable {
    let banner: [Banner]
}

// MARK: - Banner
struct Banner: Decodable {
    let name, image, status: String
}
