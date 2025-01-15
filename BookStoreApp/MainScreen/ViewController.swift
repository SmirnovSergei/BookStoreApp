//
//  ViewController.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import UIKit

class ViewController: UIViewController {
	
	struct ElementKind {
		static let badge = "badge-element-kind"
	}
	
	var bookStoreManager: IBookStoreDataManager!
	private var library: [BookType] = []
	
	private let reuseIdentifier = "reuseIdentifier"
	private var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		library = bookStoreManager.getBookTypes()
		setupView()
		configureCollectionView()
	}
	
	
}

//MARK: - Setup View
private extension ViewController {
	func setupView() {
		let layout = createLayout()
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		
		collectionView.register(
			SectionHeaderView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: SectionHeaderView.reuseIdentifier
		)
		
		collectionView.register(
			BadgeView.self,
			forSupplementaryViewOfKind: ElementKind.badge,
			withReuseIdentifier: BadgeView.reuseIdentifier
		)
		
		collectionView.backgroundColor = .systemFill
		collectionView.dataSource = self
		
		view.addSubview(collectionView)
	}
}

//MARK: - Settings Layout
private extension ViewController {
	func createLayout() -> UICollectionViewLayout {
		let supplementaryItemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(100),
			heightDimension: .absolute(25)
		)
		
		let constraints = NSCollectionLayoutAnchor(
			edges: [.top, .leading],
			absoluteOffset: CGPoint(x: 0, y: -20)
		)
		
		let supplementaryItem = NSCollectionLayoutSupplementaryItem(
			layoutSize: supplementaryItemSize,
			elementKind: ElementKind.badge,
			containerAnchor: constraints
		)
		
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.5),
			heightDimension: .fractionalHeight(1)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [supplementaryItem])
		item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 0)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(135)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		group.interItemSpacing = .fixed(15)
		
		let headerSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(50)
		)
		
		let header = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 80, trailing: 0)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [header]
		
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

//MARK: - CollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		library.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		library[section].books.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CustomCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.configure(with: library[indexPath.section].books[indexPath.row])
		
		return cell
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let header = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: SectionHeaderView.reuseIdentifier,
				for: indexPath
			) as! SectionHeaderView
			header.configure(text: library[indexPath.section].type)
			return header
		} else if kind == ElementKind.badge {
			let badge = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: BadgeView.reuseIdentifier,
				for: indexPath
			) as! BadgeView
			if library[indexPath.section].books[indexPath.row].isNew {
				badge.configureBadge(text: "Новинка")
			} else {
				badge.isHidden = true
			}
			return badge
		}
		return UICollectionReusableView()
	}
}
