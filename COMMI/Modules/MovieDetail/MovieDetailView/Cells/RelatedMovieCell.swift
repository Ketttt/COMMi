//
//  RelatedMovieCell.swift
//  COMMI
//
//  Created by Katerina Dev on 20.10.24.
//

import UIKit

final class RelatedMovieCell: UITableViewCell  {
    
    private var trendingMovies: [TrendingMovie]?
    
    func setMoviesData(_ movies: [TrendingMovie]) async {
        self.trendingMovies = movies
        guard !movies.isEmpty else { return }
        await MainActor.run {
            self.collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout =  UICollectionViewFlowLayout ()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = .init(width: 172, height: 176)
        flowLayout.minimumLineSpacing = 20
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(RelatedMovieCollectionCell.self, forCellWithReuseIdentifier: "RelatedMovieCollectionCell")
        collectionView.dataSource  = self
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .normal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    private func setUp() {
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RelatedMovieCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension RelatedMovieCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedMovieCollectionCell", for: indexPath) as? RelatedMovieCollectionCell else { return UICollectionViewCell() }
        guard let movie = trendingMovies?[indexPath.row] else { return cell }
        cell.setData(trendingMovie: movie)
        return cell
    }
}
