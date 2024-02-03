//
//  WebData.swift
//  Coding_excercise
//
//  Created by Neethu on 02/02/2024.
//

import Foundation

struct WebData : Codable {
    var parse: Parse
}
   
struct Parse: Codable {
    var title: String
    var pageid:Int
    var text: TextObject
}

struct TextObject: Codable {
    var content: String
    enum CodingKeys: String, CodingKey {
        case content = "*"
    }
}
