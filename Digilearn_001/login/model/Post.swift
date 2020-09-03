//
//  Post.swift
//  Digilearn_001
//
//  Created by Teke on 03/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation

struct Post : Decodable{
    let id: Int
    let title: String
    let body: String
}
