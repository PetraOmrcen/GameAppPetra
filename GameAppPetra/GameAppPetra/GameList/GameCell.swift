import Foundation

import UIKit
import SnapKit

// MARK: - UITableViewCell
class GameCell: UITableViewCell, Reusable {
    
    private let label = UILabel()
    private let container = UIView()
    private var originalBackgroundColor:UIColor?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addViews(){
        container.addAsSubviewOf(contentView)
        label.addAsSubviewOf(container)
    }
    
    func styleViews(){
        selectionStyle = .none
        
        container.backgroundColor(.pennBlue)
        container.layer.cornerRadius = 20.0
        
        label.font = UIFont(name: "Panchang-Medium", size: 12)
        label.textColor(.white)
        label.numberOfLines = 0
    }
    
    func setupConstraints(){
        container.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview()
            
        }
    }
}

extension GameCell: Configurable {
    
    @discardableResult
    func configure(with model: Any) -> Self {
        guard let model = model as? GameCellModel else { return self }
        label.text(model.name)
        return self
    }

    private func getId(from string: String?) -> String? {
        string?
            .split(separator: " ")
            .last?
            .description
    }
}
