//
//  HomeViewController.swift
//  COMMI
//
//  Created by Katerina Ivanova on 30.10.2023.
//

import UIKit
import Kingfisher

@MainActor
protocol IHomeView {
    func updateView(movie: [TrendingMovie]) async
}

final class HomeViewController: UIViewController {
    
    var presenter: IHomePresenter?
    private var trending: [TrendingMovie] = []
    private let headerView = HeroHeaderUIView()
    private lazy var collectionTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setUp()
        presenter?.viewDidLoad()
        Task {
            await updateView(movie: trending)
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 50.0)
        collectionView.register(TrendingMoviesCell.self, forCellWithReuseIdentifier: "TrendingMoviesCellID")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private func configureNavBar() {
        let label = UILabel()
        label.frame = CGRect(x: 24, y: 44, width: 214, height: 29)
        let stringValue = "Stream Everywhere"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColorForText(textForAttribute: "Stream", withColor: UIColor.tabBarItemAccent)
        attributedString.setColorForText(textForAttribute: "Everywhere", withColor: UIColor.white)
        label.font = UIFont.systemFont(ofSize: 24)
        label.attributedText = attributedString
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationController?.navigationBar.backgroundColor = UIColor(resource: .main)
        navigationController?.navigationBar.barTintColor = UIColor(resource: .main)
    }
    
    func setUp() {
        self.view.backgroundColor = UIColor(resource: .main)
        self.view.addSubview(headerView)
        self.view.addSubview(collectionView)
        self.view.addSubview(collectionTitle)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        collectionTitle.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionTitle.text = "Trending"
        collectionTitle.textColor = UIColor.white
        collectionTitle.font = UIFont(name: "Helvetica", size: 24)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerView.heightAnchor.constraint(equalToConstant: 211),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            collectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            collectionTitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: collectionTitle.bottomAnchor, constant: 8),
            collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
        ])
    }
}


//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMoviesCellID", for: indexPath) as? TrendingMoviesCell else { fatalError("Failed to dequeue TrendingMoviesCell") }
        let trendingMovie = self.trending[indexPath.item]
        cell.setData(trendingMovie: trendingMovie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trending.count
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.cellForItem(at: indexPath) as! TrendingMoviesCell
        presenter?.showMovieDetail(with: trending[indexPath.item].movie?.id ?? "")
    }
}

//MARK: - IHomeView
extension HomeViewController: IHomeView {
    func updateView(movie: [TrendingMovie]) async {
        self.trending = movie
        self.collectionView.reloadData()
    }
}
