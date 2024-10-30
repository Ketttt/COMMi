//
//  TrendingMoviesCell.swift
//  COMMI
//
//  Created by Katerina Dev on 25.09.24.
//

import UIKit
import Kingfisher

final class TrendingMoviesCell: UICollectionViewCell {
    
    func setData(trendingMovie: TrendingMovie) {
        if let url = URL(string: trendingMovie.movie?.image_url ?? "") {
            self.containerView.kf.setImage(with: url,
                                           placeholder: UIImage(named: "placeholder"),
                                           options: [.transition(.fade(0.2)), .backgroundDecode])
            self.ratingView.ratingLabel.text = String(trendingMovie.movie?.rating ?? 0)
            self.ratingView.resourseLabel.text = trendingMovie.movie?.genre
            self.movieTitleView.movieTitle.text = trendingMovie.movie?.title
        }
    }
    
    private let movieTitleView = MovieTitle()
    private let ratingView = RatingView()
    private var containerView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    private func setUp() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 20
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        self.addSubview(containerView)
        self.insertSubview(ratingView, aboveSubview: containerView)
        self.insertSubview(movieTitleView, aboveSubview: containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        movieTitleView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            movieTitleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            movieTitleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            movieTitleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            movieTitleView.heightAnchor.constraint(equalToConstant: 42),
            
            ratingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            ratingView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 9)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
