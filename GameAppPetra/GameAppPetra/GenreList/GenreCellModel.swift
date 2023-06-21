//
//  GenreCellModel.swift
//  GamesApp
//
//  Created by Akademija on 20.06.2023..
//
import UIKit

struct GenreCellModel{
    
    let reusedId: String = GenreCell.identifier
    let genreId: Int
    let name: String
    var selected: Bool = false
    let backroundImage: UIImage
    let urlBackroundImage: String
}
