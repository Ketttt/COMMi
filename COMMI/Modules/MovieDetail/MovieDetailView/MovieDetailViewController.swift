//
//  MovieDetailViewController.swift
//  COMMI
//
//  Created by Katerina Dev on 11.10.24.
//

import UIKit
import Kingfisher

@MainActor
protocol IMovieDetailView {
    func relatedMovies(movies: [TrendingMovie]) async
    func movieDetail(movie: TrendingMovie) async
}

final class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailPresenter?
    private var trending: [TrendingMovie] = []
    private var movie: TrendingMovie = TrendingMovie()
    private let tableView = UITableView()
    private let headerImageView = UIImageView()
    private let headerHeight: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupHeader()
        navigationController?.navigationBar.backgroundColor = .clear
        presenter?.viewDidLoad()
        Task {
            await relatedMovies(movies: trending)
            await movieDetail(movie: movie)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = UIColor.main
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(MainInfoTableViewCell.self, forCellReuseIdentifier: "MainInfoTableViewCell")
        tableView.register(ExtraInfoTableViewCell.self, forCellReuseIdentifier: "ExtraInfoTableViewCell")
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "DescriptionTableViewCell")
        tableView.register(RelatedMovieCell.self, forCellReuseIdentifier: "RelatedMovieCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }
    
    private func setupHeader() {
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight))
        headerImageView.frame = headerView.bounds
        headerView.addSubview(headerImageView)
        tableView.tableHeaderView = headerView
    }
    
// MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            headerImageView.frame = CGRect(x: offsetY / 2, y: offsetY, width: view.frame.width - offsetY, height: headerHeight - offsetY)
        }
    }
}

// MARK: - UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainInfoTableViewCell", for: indexPath) as? MainInfoTableViewCell else { return UITableViewCell() }
            cell.contentView.backgroundColor = UIColor.main
            cell.setData(movie: movie)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExtraInfoTableViewCell", for: indexPath) as? ExtraInfoTableViewCell else { return UITableViewCell() }
            cell.contentView.backgroundColor = UIColor.main
            cell.setData(movie: movie)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as? DescriptionTableViewCell else { return UITableViewCell() }
            cell.contentView.backgroundColor = UIColor.main
            cell.setData(movie: movie)
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedMovieCell", for: indexPath) as? RelatedMovieCell else { return UITableViewCell() }
            cell.contentView.backgroundColor = UIColor.main
            Task {
                await cell.setMoviesData(trending)
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - IMovieDetailView
extension MovieDetailViewController: IMovieDetailView {
    func relatedMovies(movies: [TrendingMovie]) async {
        self.trending = movies
        self.tableView.reloadData()
    }

    func movieDetail(movie: TrendingMovie) async {
        self.movie = movie
        await MainActor.run { [weak self] in
            guard let self = self else { return }
            if let url = URL(string: movie.movie?.image_url ?? "") {
                self.headerImageView.kf.setImage(with: url,
                                                placeholder: UIImage(named: "placeholder"),
                                                options: [.transition(.fade(0.2)), .backgroundDecode])
            }
        }
        self.tableView.reloadData()
    }
}
