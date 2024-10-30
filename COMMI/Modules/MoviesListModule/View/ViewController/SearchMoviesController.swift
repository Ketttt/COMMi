//
//  SearchMoviesController.swift
//  COMMI
//
//  Created by Katerina Ivanova on 26.10.2023.
//

import UIKit

@MainActor
protocol ISearchView {
    func updateView(movie: SearchResult) async
}

final class SearchMoviesController: UIViewController {
    
    var presenter: ISearchPresenter?
    private var headerView = SearchHeaderView()
    private var searchMovies : SearchResult = SearchResult()
    private var currentCategory: [Movie] = []
    
    private lazy var menuCollectionView: UICollectionView = {
        let layout = CustomFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: view.bounds.width / 2 - 40, height: 270)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .normal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return collectionView
    }()
    
    private func configureNavBar() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Find Movies, Tv series, and more.."
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        let customView = UIView()
        customView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            label.topAnchor.constraint(equalTo: customView.topAnchor),
            label.bottomAnchor.constraint(equalTo: customView.bottomAnchor)
        ])
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
        customView.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        navigationController?.navigationBar.backgroundColor = UIColor(resource: .main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setUp()
        presenter?.viewDidLoad()
        Task {
            await updateView(movie: searchMovies)
        }
        headerView.delegate = self
    }
    
    func setUp() {
        view.backgroundColor = .main
        view.addSubview(headerView)
        view.addSubview(menuCollectionView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
            
            menuCollectionView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 20),
            menuCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension SearchMoviesController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        let movie = currentCategory[indexPath.item]
                cell.setData(searchMovie: movie)
        return cell
    }
}

//MARK: - ISearchView
extension SearchMoviesController: ISearchView {
    func updateView(movie: SearchResult) async {
        self.searchMovies = movie
        self.currentCategory = searchMovies.movies ?? []
        self.menuCollectionView.reloadData()
    }
}

//MARK: - SearchHeaderViewDelegate
extension SearchMoviesController: SearchHeaderViewDelegate {
    func didSelectMenuItem(_ menuItem: MenuTitles) {
        switch menuItem {
        case .movies:
            currentCategory = searchMovies.movies ?? []
        case .tvSeries:
            currentCategory = searchMovies.tv ?? []
        case .documentary:
            currentCategory = searchMovies.documentary ?? []
        case .sports:
            currentCategory = searchMovies.sports ?? []
        }
        menuCollectionView.reloadData()
    }
}
