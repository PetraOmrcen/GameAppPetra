//
//  GenreModel.swift
//  FinalGameApp
//
//  Created by Akademija on 20.06.2023..
//

import Foundation
import UIKit

struct GenreModel: Codable{
    
    let genreId: Int
    let name: String
    var selected: Bool = false
    let backroundImage: String
}
