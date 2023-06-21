//
//  HeaderView.swift
//  GameApp
//
//  Created by Akademija on 11.06.2023..
//

import UIKit
import SnapKit

final class HeaderView: BaseView {
    
    private let logoName = UILabel()
    
    override func addViews(){
        addSubview(logoName)
    }

    override func styleViews(){
        backgroundColor = UIColor.black
        logoName.text("GAME APP")
        logoName.textColor(.white)
        logoName.font = UIFont(name: "Panchang-Semibold", size: 25)
        //UIFontMetrics.default.scaledFont
    }

    override func setupConstraints(){
        logoName.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.bottom.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview()
        }
        
        
    }
}
