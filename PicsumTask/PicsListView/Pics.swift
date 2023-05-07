//
//  Pics.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import Foundation

struct Pics: Decodable{
    let id: String
    let author: String
    let url: String
    let downloadUrl: String
    var isSelected: Bool?
    
    private enum CodingKeys : String, CodingKey {
        case id
        case author
        case url
        case downloadUrl = "download_url"
        case isSelected
    }
}
