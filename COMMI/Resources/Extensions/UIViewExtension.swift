//
//  UIViewExtension.swift
//  COMMI
//
//  Created by Katerina Dev on 24.09.24.
//

import UIKit

extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}

extension UIView {
    func addBorderGradient(to view: UIView,_ cornerRadius: CGFloat = 20) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.borderColor.withAlphaComponent(0.42).cgColor,
                           UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        
        let shape = CAShapeLayer()
        shape.lineWidth = 1.7
        let ovalRect = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        shape.path = UIBezierPath(roundedRect: ovalRect, cornerRadius: cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        gradient.mask = shape
        view.layer.addSublayer(gradient)
    }
}
