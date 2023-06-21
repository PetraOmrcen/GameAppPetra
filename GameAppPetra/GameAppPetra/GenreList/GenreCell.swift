//
//  GenreCell.swift
//  GameApp
//
//  Created by Akademija on 14.06.2023..
//

import Alamofire
import AlamofireImage
import UIKit
import SnapKit


class GenreCell: UITableViewCell, Reusable {
    
    private let label = UILabel()
    private let backroundImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addViews(){
        label.addAsSubviewOf(contentView)
        backroundImage.addAsSubviewOf(contentView)
    }
    
    func styleViews(){
        label.font = UIFont(name: "Panchang-Medium", size: 15)
        label.textColor(.blue)
        label.numberOfLines = 0
        
        backroundImage.layer.borderWidth = 2.0
        backroundImage.layer.borderColor = UIColor.blue.cgColor
        backroundImage.layer.cornerRadius = 8.0
        backroundImage.layer.masksToBounds = true
    }
    
    func setupConstraints(){
        backroundImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(30)
            $0.height.equalTo(40)
            $0.width.equalTo(100)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(backroundImage.snp.trailing).offset(30)
            $0.trailing.equalTo(contentView).inset(30)
        }
    }
}

extension GenreCell: Configurable {
    
    @discardableResult
    func configure(with model: Any) -> Self {
        guard let model = model as? GenreCellModel else { return self }
        label.text(model.name)
        backroundImage.image(model.backroundImage)
        return self
    }

    private func getId(from string: String?) -> String? {
        string?
            .split(separator: " ")
            .last?
            .description
    }
}
