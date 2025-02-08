//
//  SectionHeaderView.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 15.01.2025.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {
	
	static let reuseIdentifier = "SectionHeaderView"
	private let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		label.textColor = .white
		label.frame = bounds
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
		addSubview(label)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(text: String) {
		label.text = text
	}
}
