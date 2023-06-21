//
//  GameDetailViewController.swift
//  GameApp
//
//  Created by Akademija on 11.06.2023..
//

import UIKit

class GameDetailViewController: UIViewController {
    
    private var onDataFetched: (() -> Void)? = nil
    private let gameId: Int
    
    private let gameName = UILabel()
    private let gameDescription = UILabel()
    private let backroundImage = UIImageView()
    private let backroundImageAdditional = UIImageView()
    private let released = UILabel()
    private let webside = UILabel()
    private let rating = UILabel()
    private let descriptionHeading = UILabel()
    
    private let responseAPI = NetworkManager()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stack = UIStackView()
    
    private let showMoreButton = UIButton()
    
    private var detailsResponse: DetailResponse = DetailResponse(
        id: 0,
        slug: "",
        name: "",
        name_original: "",
        description: "",
        released: "",
        tba: false,
        updated: "",
        background_image: "",
        background_image_additional: "",
        website: "",
        rating: 0,
        rating_top: 0)
    
    private var detailModel: DetailModel = DetailModel(
        id: 0, name: "",
        description: "",
        released: "",
        backgroundImage: "",
        backgroundImageAdditional: "",
        website: "",
        rating: 0)
    
    
    init(gameId: Int) {
        self.gameId = gameId
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails()
        addViews()
        styleViews()
        setupConstraints()
        
        onDataFetched = {
            self.styleViews()
        }
        
    }
    
    func addViews(){
        scrollView.addAsSubviewOf(view)
        
        contentView.addAsSubviewOf(scrollView)
        
        backroundImage.addAsSubviewOf(contentView)
        gameName.addAsSubviewOf(contentView)
        descriptionHeading.addAsSubviewOf(contentView)
        gameDescription.addAsSubviewOf(contentView)
        showMoreButton.addAsSubviewOf(contentView)
        backroundImageAdditional.addAsSubviewOf(contentView)
        stack.addAsSubviewOf(contentView)
        
        stack.addArrangedSubviews(released, rating, webside)
        
    }
    
    func styleViews(){
        
        view.backgroundColor(.black)
        
        gameName
            .text(detailModel.name)
            .textColor(.white)
            .numberOfLines = 0
        gameName.font = UIFont(name: "Panchang-Semibold", size: 30)
        
        gameDescription
            .text(detailModel.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))
            .textColor(.white)
            .numberOfLines = 5
        gameDescription.font = UIFont(name: "Panchang-Medium", size: 10)
        gameDescription.lineBreakMode = .byTruncatingTail
        
        descriptionHeading
            .text("DESCRIPTION:")
            .textColor(.blue)
        descriptionHeading.font = UIFont(name: "Panchang-Bold", size: 15)
        
        showMoreButton.setTitle("Show More...", for: .normal)
        showMoreButton.addTarget(self, action: #selector(showMoreButtonTapped), for: .touchUpInside)
        showMoreButton.setTitleColor(.white, for: .normal)
        showMoreButton.titleLabel?.font = UIFont(name: "Panchang-Bold", size: 10)
        
        
        backroundImage.loadFrom(URLAddress: detailModel.backgroundImage)
        backroundImage.layer.borderWidth = 3.0
        backroundImage.layer.borderColor = UIColor.blue.cgColor
        backroundImage.layer.cornerRadius = 8.0
        backroundImage.layer.masksToBounds = true
        
        backroundImageAdditional.loadFrom(URLAddress: detailModel.backgroundImageAdditional)
        
        released
            .text("RELEASED: " + detailModel.released)
            .textColor(.gray)
        released.font = UIFont(name: "Panchang-Medium", size: 15)
        
        rating
            .text("RATING: " + String(detailModel.rating))
            .textColor(.gray)
        rating.font = UIFont(name: "Panchang-Medium", size: 15)
        
        webside
            .text("WEBSIDE: " +  detailModel.website)
            .textColor(.gray)
            .numberOfLines = 0
        webside.font = UIFont(name: "Panchang-Medium", size: 15)
        
        stack.axis = .vertical
        stack.spacing = 10.0
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        gameName.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            
        }
        
        backroundImage.snp.makeConstraints {
            $0.top.equalTo(gameName.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(200)
        }
        
        descriptionHeading.snp.makeConstraints {
            $0.top.equalTo(backroundImage.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(30)
        }
        
        gameDescription.snp.makeConstraints {
            $0.top.equalTo(descriptionHeading.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        showMoreButton.snp.makeConstraints {
            $0.top.equalTo(gameDescription.snp.bottom).offset(3)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        backroundImageAdditional.snp.makeConstraints {
            $0.top.equalTo(gameDescription.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        stack.snp.makeConstraints {
            $0.top.equalTo(backroundImageAdditional.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.lessThanOrEqualToSuperview().offset(-30)
        }
    }
    
    func getDetails(){
        Task {
            if let cellList1 =  try await responseAPI.fetchDetails(id: gameId) {
                detailsResponse = cellList1
                loadDataToModel()
                onDataFetched?()
            }
        }
    }
    
    func loadDataToModel(){
        detailModel = DetailModel(
            id: detailsResponse.id,
            name: detailsResponse.name,
            description: detailsResponse.description,
            released: detailsResponse.released,
            backgroundImage: detailsResponse.background_image,
            backgroundImageAdditional: detailsResponse.background_image_additional,
            website: detailsResponse.website,
            rating: detailsResponse.rating
        )
    }
    
    @objc private func showMoreButtonTapped() {
        gameDescription.numberOfLines = gameDescription.numberOfLines == 0 ? 5 : 0
        let buttonTitle = gameDescription.numberOfLines == 0 ? "Show Less" : "Show More..."
        showMoreButton.setTitle(buttonTitle, for: .normal)
    }
    
}



