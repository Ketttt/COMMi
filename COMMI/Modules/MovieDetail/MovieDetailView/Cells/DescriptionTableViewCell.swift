//
//  DescriptionTableViewCell.swift
//  COMMI
//
//  Created by Katerina Dev on 22.10.24.
//

import UIKit

final class DescriptionTableViewCell: UITableViewCell {
    
    func setData(movie: TrendingMovie) {
        self.discription.text = movie.movie?.description
    }
    
    private let title: UILabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.textColor = .white
        label.font = UIFont.init(name: "Helvetica", size: 20)
        return label
    }()
    
    private let discription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.subtitleColor
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = UIFont.init(name: "Helvetica", size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    func setUp() {
        title.translatesAutoresizingMaskIntoConstraints = false
        discription.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(title)
        self.contentView.addSubview(discription)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            
            discription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            discription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            discription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            discription.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
