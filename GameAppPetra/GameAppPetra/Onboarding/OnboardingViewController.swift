
//  ViewController.swift
//  GameApp
//
//  Created by Akademija on 09.06.2023..
//

import UIKit
import Alamofire

class OnboardingViewController: UIViewController {
    
    let header = HeaderView()
    let table = GenreListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.buttonClickedHandler = {
            let secondVC = ListGamesController()
            Preference.isFirstLaunch = true
            self.navigationController?.pushViewController(secondVC, animated: true)
            }
        
        table.getDataHandler = { [self] in
            table.getGenres()
        }
        
        addViews()
        styleViews()
        setupConstraints()
    }

    func addViews(){
        header.addAsSubviewOf(view)
    
        addChild(table)
        view.addSubview(table.view)
        table.view.translatesAutoresizingMaskIntoConstraints = false
        didMove(toParent: self)
    }

    func styleViews(){
    }

    func setupConstraints(){
        header.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }

        table.view.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

    }

}
