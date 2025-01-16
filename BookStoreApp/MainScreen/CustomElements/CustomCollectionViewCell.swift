//
//  CustomCollectionViewCell.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 15.01.2025.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
	
	private let bookImage = UIImageView()
	private let bookTitle = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with book: Book) {
		bookTitle.text = book.title
		bookImage.image = UIImage(named: book.image)
	}
}

//MARK: - Setup Views
private extension CustomCollectionViewCell {
	func setupViews() {
		contentView.addSubview(bookImage)
		contentView.addSubview(bookTitle)
		
		setupImage()
		setupLabel()
	}
	
	func setupLabel() {
		bookTitle.font = .systemFont(ofSize: 15, weight: .semibold)
		bookTitle.textColor = .white
		bookTitle.numberOfLines = 4
		bookTitle.textAlignment = .left
	}
	
	func setupImage() {
		bookImage.layer.cornerRadius = 5
		bookImage.clipsToBounds = true
		bookImage.contentMode = .scaleAspectFill
		bookImage.layer.masksToBounds = true
	}
}

//MARK: - Setup Layout
private extension CustomCollectionViewCell {
	func setupLayout() {
		bookImage.translatesAutoresizingMaskIntoConstraints = false
		bookTitle.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			bookImage.topAnchor.constraint(equalTo: contentView.topAnchor),
			bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			bookImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			bookImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			
			bookTitle.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 15),
			bookTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			bookTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			//			bookTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
