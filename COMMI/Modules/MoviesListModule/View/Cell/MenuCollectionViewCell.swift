//
//  MenuCollectionViewCell.swift
//  COMMI
//
//  Created by Katerina Ivanova on 28.10.2023.
//

import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setData(searchMovie: Movie) {
        if let url = URL(string: searchMovie.item.imageURL ) {
            self.imageView.kf.setImage(with: url,
                                       placeholder: UIImage(named: "placeholder"),
                                       options: [.transition(.fade(0.2)), .backgroundDecode])
            
            self.label.text = searchMovie.item.title
        }
    }
    
    private func setUp() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -4),
            
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

