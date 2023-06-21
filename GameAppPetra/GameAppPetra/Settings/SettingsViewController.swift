//
//  SettingsViewController.swift
//  GameApp
//
//  Created by Akademija on 15.06.2023..
//

import UIKit

class SettingsViewController: UIViewController {
    
    let table = GenreListViewController()
    weak var delegate: ListGamesControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.buttonClickedHandler = { [self] in
            self.delegate?.reloadTable()
            self.dismiss(animated: true, completion: nil)
            }
        
        table.getDataHandler = { [self] in
            table.getModel()
        }
        
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews(){
        addChild(table)
        view.addSubview(table.view)
        table.view.translatesAutoresizingMaskIntoConstraints = false
        didMove(toParent: self)
    }
    
    func styleViews(){
    }
    
    func setupConstraints(){
        table.view.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
