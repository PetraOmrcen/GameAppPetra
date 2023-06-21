//
//  GameDetail.swift
//  GameApp
//
//  Created by Akademija on 12.06.2023..
//

import Foundation

struct DetailResponse: Decodable {
    let id: Int
    let slug: String
    let name: String
    let name_original: String
    let description: String
    let released: String
    let tba: Bool
    let updated: String
    let background_image: String
    let background_image_additional: String
    let website: String
    let rating: Double
    let rating_top: Double

}
