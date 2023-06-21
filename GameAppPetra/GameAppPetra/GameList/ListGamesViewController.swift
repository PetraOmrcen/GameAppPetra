//
//  ListViewController.swift
//  GameApp
//
//  Created by Akademija on 11.06.2023..
//

import UIKit

class ListGamesController: UIViewController {
    
    private var model: [GameCellModel] = []
    private let tableView = UITableView()
    private let responseAPI = NetworkManager()
    private var genreList: GenresResponse = GenresResponse(count: 0, next: "", previous: "", results: [])
    private var selectedGenresList = Preference.selectedGenres
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        getGenres()
        addViews()
        styleViews()
        setupConstraints()
    }

    @objc func addButtonTapped(){
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        present(settingsVC, animated: true)

    }

    func getGenres(){
        Task {
            if let cellList1 =  try await responseAPI.fetchGenres() {
                genreList = cellList1
                loadDataToModel()
                self.tableView.reloadData()
            }
        }
    }

    func loadDataToModel() {
        model = []
        let selectedGenresList = Preference.selectedGenres
        for result in genreList.results {
            for sel in selectedGenresList where sel.genreId == result.id && sel.selected {
                for game in result.games {
                    let gameModel = GameCellModel(gameId: game.id, name: game.name)
                    model.append(gameModel)
                }
            }
        }
    }

    func addViews() {
        tableView.addAsSubviewOf(view)
    }

    func styleViews() {

        navigationItem.setHidesBackButton(true, animated: true)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton

        tableView.backgroundColor(.black)
        tableView.separatorStyle = .none
        tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ListGamesController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier) else {
            return UITableViewCell()
        }
        let index = indexPath.row
        if let configurable = cell as? Configurable, index >= 0 && index < model.count {
            configurable.configure(with: model[indexPath.row])
        }

        cell.backgroundColor(.black)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let detail = GameDetailViewController(gameId: model[indexPath.row].gameId)
        navigationController?.pushViewController(detail, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ListGamesController: ListGamesControllerDelegate{
    func reloadTable(){
        self.loadDataToModel()
        self.tableView.reloadData()
    }
}

extension ListGamesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
            filterModel(with: searchText)
        }
    }

    private func filterModel(with searchText: String) {
        if searchText.isEmpty {
            loadDataToModel()
        } else {
            model = model.filter { $0.name.lowercased().contains(searchText) }
        }
        tableView.reloadData()
    }
}

protocol ListGamesControllerDelegate: AnyObject {
    func reloadTable()
}
