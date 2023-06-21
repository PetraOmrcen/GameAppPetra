//
//  OnboardingViewController.swift
//  GameApp
//
//  Created by Akademija on 11.06.2023..
//

import UIKit
import Alamofire
import AlamofireImage

class GenreListViewController: UIViewController {

    private var onDataFetched: (() -> Void)? = nil
    private var cellList: GenresResponse = GenresResponse(count: 0, next: "", previous: "", results: [])
    private let submitButton = UIButton()
    private var model:[GenreCellModel] = []
    private let probaAPI = NetworkManager()
    private let tableView = UITableView()
    private let loadingImage = UIImage()
    
    var buttonClickedHandler: (() -> Void)?
    var getDataHandler: (() -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getData()
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews(){
        submitButton.addAsSubviewOf(view)
        tableView.addAsSubviewOf(view)
    }
    
    func styleViews(){
        view.backgroundColor(.black)
        
        tableView.backgroundColor(.black)
        tableView.register(GenreCell.self, forCellReuseIdentifier: GenreCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor(.darkBlue)
        submitButton.layer.cornerRadius = 15.0
        submitButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        submitButton.titleLabel?.font = UIFont(name: "Panchang-Bold", size: 12)
    }

    
    func setupConstraints(){
        submitButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(35)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(submitButton.snp.top)
        }
    }
    
    @objc func buttonClicked() {
        saveGenres()
        buttonClickedHandler?()
        }
    
    func getData(){
        getDataHandler?()
    }
    
    func getGenres(){
        self.onDataFetched = {
            self.tableView.reloadData()
        }
        
        Task {
            if let cellList1 =  try await probaAPI.fetchGenres() {
                cellList = cellList1
                loadDataToModel()
                onDataFetched?()
            }
        }
    }
    
    func getModel() {
        for genre in Preference.selectedGenres {
            let imageURL = URL(string: genre.backroundImage)!
            
            let placeholderImage = UIImage(named: "placeholder") // Placeholder image
            
            Alamofire.AF.request(imageURL).responseData { response in
                if let data = response.data, let image = UIImage(data: data) {
                    // Image loaded successfully
                    self.model.append(GenreCellModel(
                        genreId: genre.genreId,
                        name: genre.name,
                        selected: genre.selected,
                        backroundImage: image,
                        urlBackroundImage: genre.backroundImage))
                } else {
                    // Failed to load the image, use placeholder
                    self.model.append(GenreCellModel(
                        genreId: genre.genreId,
                        name: genre.name,
                        selected: genre.selected,
                        backroundImage: placeholderImage ?? self.loadingImage,
                        urlBackroundImage: genre.backroundImage))
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private
    
    private func loadDataToModel(){
        for result in cellList.results{
            let imageURL = URL(string: result.image_background)!
            
            let placeholderImage = UIImage(named: "placeholder") // Placeholder image
            
            Alamofire.AF.request(imageURL).responseData { response in
                if let data = response.data, let image = UIImage(data: data) {
                    // Image loaded successfully
                    self.model.append(GenreCellModel(
                        genreId: result.id,
                        name: result.name,
                        backroundImage: image,
                        urlBackroundImage: result.image_background))
                } else {
                    // Failed to load the image, use placeholder
                    self.model.append(GenreCellModel(
                        genreId: result.id,
                        name: result.name,
                        backroundImage: placeholderImage ?? self.loadingImage,
                        urlBackroundImage: result.image_background))
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    private func saveGenres(){
        Preference.selectedGenres = []
        var genreModelList: [GenreModel] = []
        
        for genre in model {
            genreModelList.append(GenreModel(genreId: genre.genreId, name: genre.name,  selected: genre.selected, backroundImage: genre.urlBackroundImage))
        }
        Preference.selectedGenres = genreModelList
        self.tableView.reloadData()
       
    }
}

extension GenreListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreCell.identifier) else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        if let configurable = cell as? Configurable, index >= 0 && index < model.count {
            configurable.configure(with: model[indexPath.row])
        }
        
        if model[indexPath.row].selected {
            cell.backgroundColor = .neonBlue
        } else {
            cell.backgroundColor = .black
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        model[indexPath.row].selected = !model[indexPath.row].selected
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
