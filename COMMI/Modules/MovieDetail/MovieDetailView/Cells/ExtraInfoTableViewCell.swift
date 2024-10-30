//
//  ExtraInfoTableViewCell.swift
//  COMMI
//
//  Created by Katerina Dev on 21.10.24.
//

import UIKit

final class ExtraInfoTableViewCell: UITableViewCell {
    
    func setData(movie: TrendingMovie) {
        self.releaseData.text = movie.movie?.releaseDate
        self.genreData.titleLabel.text = movie.movie?.genre
    }
    
    private let releaseTitle: UILabel = {
        let releaseTitle = UILabel()
        releaseTitle.text = "Release date"
        releaseTitle.textColor = .white
        releaseTitle.font = UIFont.systemFont(ofSize: 17.3)
        return releaseTitle
    }()
    
    private let genre: UILabel = {
        let genre = UILabel()
        genre.text = "Genre"
        genre.textColor = .white
        genre.font = UIFont.systemFont(ofSize: 17.3)
        return genre
    }()
    
    private let releaseData: UILabel = {
        let releaseData = UILabel()
        releaseData.textColor = UIColor.subtitleColor
        releaseData.font = UIFont.systemFont(ofSize: 12)
        return releaseData
    }()
    
    private let genreData = CustomView(frame: .init(x: 0, y: 0, width: 64, height: 28), borderRadius: 14)
    
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor.subtitleColor.withAlphaComponent(0.5)
        return divider
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    func setUp() {
        self.contentView.addSubview(releaseTitle)
        self.contentView.addSubview(genre)
        self.contentView.addSubview(releaseData)
        self.contentView.addSubview(genreData)
        self.contentView.addSubview(divider)
        
        releaseTitle.translatesAutoresizingMaskIntoConstraints = false
        genre.translatesAutoresizingMaskIntoConstraints = false
        genreData.translatesAutoresizingMaskIntoConstraints = false
        releaseData.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            releaseTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            releaseTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            
            releaseData.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            releaseData.centerYAnchor.constraint(equalTo: genreData.centerYAnchor),
            
            genre.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            genre.leadingAnchor.constraint(equalTo: self.releaseTitle.trailingAnchor, constant: 50),
            
            genreData.centerXAnchor.constraint(equalTo: genre.centerXAnchor, constant: 8),
            genreData.topAnchor.constraint(equalTo: genre.bottomAnchor, constant: 8),
            
            genreData.heightAnchor.constraint(equalToConstant: 28),
            genreData.widthAnchor.constraint(equalToConstant: 64),
            genreData.bottomAnchor.constraint(equalTo: self.divider.topAnchor, constant: -18),
            
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
