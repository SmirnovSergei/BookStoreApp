//
//  DetailViewController.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 08.02.2025.
//

import UIKit

final class DetailViewController: UIViewController {
	
	var bookStoreManager: IBookStoreDataManager!
	
	var bookID: Int
	
	private let bookImage = UIImageView()
	private let bookNameLabel = UILabel()
	private var toggleHeart = false

	init(bookStoreManager: IBookStoreDataManager, bookID: Int) {
		self.bookID = bookID
		super.init(nibName: nil, bundle: nil)
		self.bookStoreManager = bookStoreManager

	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupLayout()
	}
	
	@objc
	private func favoriteButtonTapped() {
		toggleHeart.toggle()
		setupNavigationBar()
	}
}

//MARK: - Setup View
private extension DetailViewController {
	func setupView() {
		view.backgroundColor = .black
		guard let book = bookStoreManager.getBookWithID(bookID) else { return }
		setupBookImage(book: book)
		setupBookNameLabel(book: book)
		
		[bookImage, bookNameLabel].forEach { subview in
			view.addSubview(subview)
		}
		
		setupNavigationBar()
	}
	
	func setupBookImage(book: Book) {
		bookImage.image = UIImage(named: book.image)
		
		bookImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
		bookImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
		bookImage.contentMode = .scaleAspectFill
	}
	
	func setupBookNameLabel(book: Book) {
		bookNameLabel.text = book.title
		bookNameLabel.textColor = .white
		bookNameLabel.numberOfLines = 2
		bookNameLabel.textAlignment = .center
		bookNameLabel.font = .boldSystemFont(ofSize: 22)
	}
	
	func setupNavigationBar() {
		let heart = toggleHeart ? "heart.fill" : "heart"
		
		var heartImage = UIImage(systemName: heart)
		if toggleHeart {
			heartImage = heartImage?.withTintColor(.red, renderingMode: .alwaysOriginal)
		}
		
		let favouriteButton = UIBarButtonItem(
			image: heartImage,
			style: .plain,
			target: self,
			action: #selector(favoriteButtonTapped)
		)
		
		navigationItem.rightBarButtonItem = favouriteButton
		
		navigationItem.title = "Book"
		
		navigationController?.navigationBar.prefersLargeTitles = false
	}
}

//MARK: - Setup Layout
private extension DetailViewController {
	func setupLayout() {
		[bookImage, bookNameLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		
		NSLayoutConstraint.activate([
			bookImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
			bookImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			bookNameLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 15),
			bookNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			bookNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
		])
	}
}
