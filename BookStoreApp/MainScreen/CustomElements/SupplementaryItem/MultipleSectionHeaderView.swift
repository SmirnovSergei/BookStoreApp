//
//  MultipleSectionHeaderView.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 27.01.2025.
//

import UIKit

final class MultipleSectionHeaderView: UICollectionReusableView {
	
	static let reuseIdentifier = "SectionHeaderView"
	private let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		label.textColor = .black
		label.frame = bounds
		label.textAlignment = .left
		label.font = UIFont.boldSystemFont(ofSize: 16)
		addSubview(label)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(text: String) {
		label.text = text
	}
}
