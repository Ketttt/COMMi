//
//  PlayerButton.swift
//  COMMI
//
//  Created by Katerina Dev on 24.09.24.
//

import UIKit

final class PlayerButton: UIButton {
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Continue Watching"
        label.textColor = UIColor.subtitleColor
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let labelSubtitle : UILabel = {
        let label = UILabel()
        label.text = "Ready Player one"
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let playerImage: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.image = UIImage(named: "player")
        return uiImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        applyBlurEffect()
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorderGradient(to: self)
    }
    
    private func setUp() {
        self.addSubview(playerImage)
        self.addSubview(labelTitle)
        self.addSubview(labelSubtitle)
        
        playerImage.translatesAutoresizingMaskIntoConstraints = false
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            playerImage.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            
            labelTitle.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 20),
            labelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            labelTitle.bottomAnchor.constraint(equalTo: labelSubtitle.topAnchor, constant: -4),
            
            labelSubtitle.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
