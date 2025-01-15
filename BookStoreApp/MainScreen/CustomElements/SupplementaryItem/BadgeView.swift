//
//  BadgeView.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 16.01.2025.
//

import UIKit

class BadgeView: UICollectionReusableView {
	static let reuseIdentifier = "BadgeView"
	private let badgeLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configureBadge(text: String) {
		badgeLabel.text = text
	}
}

private extension BadgeView {
	func setupView() {
		badgeLabel.frame = bounds
		badgeLabel.backgroundColor = .systemPurple
		badgeLabel.textColor = .white
		badgeLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
		badgeLabel.textAlignment = .center
		badgeLabel.layer.cornerRadius = 5
		badgeLabel.layer.masksToBounds = true
		addSubview(badgeLabel)
	}
}
