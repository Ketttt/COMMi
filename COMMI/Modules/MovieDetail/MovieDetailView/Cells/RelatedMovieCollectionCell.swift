//
//  RelatedMovieCollectionCell.swift
//  COMMI
//
//  Created by Katerina Dev on 23.10.24.
//

import UIKit

final class RelatedMovieCollectionCell: UICollectionViewCell {
    
    func setData(trendingMovie: TrendingMovie) {
        if let url = URL(string: trendingMovie.movie?.image_url ?? "") {
            self.movieImageView
                .kf.setImage(with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [.transition(.fade(0.2)), .backgroundDecode])
            guard let year = trendingMovie.movie?.year 
            else { return self.titleLabel.text = trendingMovie.movie?.title }
            if let title = trendingMovie.movie?.title {
                self.titleLabel.text = "\(title) (\(year))"
            }
        }
    }
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
        self.layer.shadowOffset = CGSize(width: 10,
                                         height: 10)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
    }
    
    private func setUp() {
        self.contentView.addSubview(movieImageView)
        self.contentView.addSubview(titleLabel)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 128),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 14)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
