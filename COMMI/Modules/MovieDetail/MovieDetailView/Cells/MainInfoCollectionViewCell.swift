//
//  MainInfoCollectionViewCell.swift
//  COMMI
//
//  Created by Katerina Dev on 22.10.24.
//

import UIKit

final class MainInfoTableViewCell: UITableViewCell {
    
    private let title: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.subtitleColor
        title.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        return title
    }()
    
    private let quality: CustomView = {
        let quality = CustomView(frame: .init(x: 0, y: 0, width: 32, height: 24), borderRadius: 6)
        return quality
    }()
    
    private let filmDuration: UILabel = {
        let filmDuration = UILabel()
        filmDuration.textColor = UIColor.subtitleColor
        filmDuration.font = .systemFont(ofSize: 12)
        return filmDuration
    }()
    
    private let durationIcon: UIImageView = {
        let durationIcon = UIImageView()
        durationIcon.image = UIImage(resource: .clock)
        durationIcon.frame = .init(x: 0, y: 0, width: 12, height: 12)
        return durationIcon
    }()
    
    private let rating: UILabel = {
        let rating = UILabel()
        rating.textColor = UIColor.subtitleColor
        rating.font = .systemFont(ofSize: 12)
        return rating
    }()
    
    private let starIcon: UIImageView = {
        let star = UIImageView()
        star.image = UIImage(resource: .grayStar)
        star.frame = .init(x: 0, y: 0, width: 12, height: 12)
        return star
    }()
    
    let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor.subtitleColor.withAlphaComponent(0.5)
        return divider
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    func setData(movie: TrendingMovie) {
        self.title.text = movie.movie?.title
        if let rating = movie.movie?.rating?.description {
            self.rating.text = "\(rating) (IMDb)"
        }
        if let filmDuration = movie.movie?.duration {
            self.filmDuration.text = ("\(filmDuration) minutes")
        }
    }
    
    func setUp() {
        
        self.contentView.addSubview(starIcon)
        self.contentView.addSubview(durationIcon)
        self.contentView.addSubview(rating)
        self.contentView.addSubview(title)
        self.contentView.addSubview(filmDuration)
        self.contentView.addSubview(divider)
        self.contentView.addSubview(quality)

        starIcon.translatesAutoresizingMaskIntoConstraints = false
        durationIcon.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        filmDuration.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        quality.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            
            quality.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            quality.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            quality.heightAnchor.constraint(equalToConstant: 24),
            quality.widthAnchor.constraint(equalToConstant: 32),
            
            durationIcon.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            durationIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            durationIcon.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -18),
            
            filmDuration.centerYAnchor.constraint(equalTo: durationIcon.centerYAnchor),
            filmDuration.leadingAnchor.constraint(equalTo: durationIcon.trailingAnchor, constant: 4),
            
            starIcon.centerYAnchor.constraint(equalTo: durationIcon.centerYAnchor),
            starIcon.leadingAnchor.constraint(equalTo: filmDuration.trailingAnchor, constant: 20),
            
            rating.centerYAnchor.constraint(equalTo: starIcon.centerYAnchor),
            rating.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 4),
            
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            divider.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            divider.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
