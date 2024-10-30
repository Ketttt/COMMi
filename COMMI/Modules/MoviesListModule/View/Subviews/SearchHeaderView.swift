//
//  SearchHeaderView.swift
//  COMMI
//
//  Created by Katerina Dev on 26.10.24.
//

import UIKit

protocol SearchHeaderViewDelegate: AnyObject {
    func didSelectMenuItem(_ menuItem: MenuTitles)
}

final class SearchHeaderView: UIView {
    weak var delegate: SearchHeaderViewDelegate?
    private let menuTitles = MenuTitles.titles
    private var selectedButton: UIButton?
    private let underlineView = UIView()
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 16
        return stackView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUp()
        for title in menuTitles {
            let button = createButton(withTitle: title)
            stackView.addArrangedSubview(button)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
              self.layoutIfNeeded()
              if let firstButton = self.stackView.arrangedSubviews.first as? UIButton {
                  self.updateUnderlinePosition(for: firstButton)
                  self.buttonTapped(firstButton)
              }
          }
    }
    
    private func updateUnderlinePosition(for button: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame = CGRect(
                x: button.frame.origin.x + 20,
                y: self.scrollView.frame.maxY,
                width: button.frame.width / 2,
                height: 2
            )
        }
    }
    
    private func setUp() {
        underlineView.backgroundColor = UIColor.systemOrange
        self.addSubview(scrollView)
        self.addSubview(underlineView)
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 38),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        selectedButton?.setTitleColor(.white, for: .normal)
        sender.setTitleColor(.systemOrange, for: .normal)
        selectedButton = sender
        updateUnderlinePosition(for: sender)
        
        if let index = stackView.arrangedSubviews.firstIndex(of: sender),
           index < menuTitles.count {
            delegate?.didSelectMenuItem(MenuTitles(rawValue: menuTitles[index]) ?? .movies)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
