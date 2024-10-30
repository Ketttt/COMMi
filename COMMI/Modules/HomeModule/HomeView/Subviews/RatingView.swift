//
//  RatingView.swift
//  COMMI
//
//  Created by Katerina Dev on 25.09.24.
//

import UIKit

final class RatingView: UIView {
    
    private let starIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(resource: .star)
        return imageView
    }()
    
    let ratingLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    let resourseLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 8)
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyBlurEffect()
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorderGradient(to: self)
    }
    
    func setUp() {
        self.addSubview(starIcon)
        self.addSubview(ratingLabel)
        self.addSubview(resourseLabel)
        
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        resourseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resourseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            resourseLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            
            starIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            starIcon.topAnchor.constraint(equalTo: resourseLabel.bottomAnchor, constant: 4),
            starIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            starIcon.widthAnchor.constraint(equalToConstant: 14),
            starIcon.heightAnchor.constraint(equalToConstant: 14),
            starIcon.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 2),
            ratingLabel.topAnchor.constraint(equalTo: resourseLabel.bottomAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
