//
//  HeroHeader.swift
//  COMMI
//
//  Created by Katerina Ivanova on 30.10.2023.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(resource: .dune)
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let playerButton: UIButton = {
        let button = PlayerButton()
        button.clipsToBounds = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        
        addSubview(heroImageView)
        addSubview(playerButton)
        
        playerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerButton.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor, constant: 12),
            playerButton.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -8),
            playerButton.heightAnchor.constraint(equalToConstant: 62),
            playerButton.widthAnchor.constraint(equalToConstant: 211)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 191)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
