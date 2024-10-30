//
//  MovieTitle.swift
//  COMMI
//
//  Created by Katerina Dev on 25.09.24.
//

import UIKit

final class MovieTitle: UIView {
    
    let movieTitle: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyBlurEffect()
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorderGradient(to: self)
    }
    
    func setUp() {
        self.addSubview(movieTitle)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            movieTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            movieTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
