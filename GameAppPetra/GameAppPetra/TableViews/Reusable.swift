//
//  Reusable.swift
//  GameApp
//
//  Created by Akademija on 13.06.2023..
//

import Foundation

protocol Reusable {

    static var identifier: String { get }
}

extension Reusable {

    static var identifier: String { String(describing: self) }
}
