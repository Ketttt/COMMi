//
//  CustomView.swift
//  COMMI
//
//  Created by Katerina Dev on 22.10.24.
//

import UIKit

final class CustomView: UIView {
    
    private var borderRadius: CGFloat
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "4K"
        label.textColor = UIColor.subtitleColor
        return label
    }()
    
    init(frame: CGRect, borderRadius: CGFloat) {
        self.borderRadius = borderRadius
        super.init(frame: frame)
        applyBlurEffect()
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBorderGradient(to: self, borderRadius)
    }
    
    func applyConstraints() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        self.borderRadius = 0
        fatalError("init(coder:) has not been implemented")
    }
}
