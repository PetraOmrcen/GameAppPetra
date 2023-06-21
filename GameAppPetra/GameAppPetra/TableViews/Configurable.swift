//
//  Configurable.swift
//  GameApp
//
//  Created by Akademija on 13.06.2023..
//

import Foundation

protocol Configurable {
    @discardableResult
    func configure(with model: Any) -> Self
}
