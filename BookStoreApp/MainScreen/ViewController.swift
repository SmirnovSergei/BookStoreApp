//
//  ViewController.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import UIKit

final class ViewController: UIViewController {
	
	struct ElementKind {
		static let badge = "badge-element-kind"
	}
	
	var bookStoreManager: IBookStoreDataManager!
	private var library: [BookType] = []
	
	private let reuseIdentifier = "reuseIdentifier"
	private var collectionView: UICollectionView!
	
	private var diffableDataSource: UICollectionViewDiffableDataSource<BookType, Book>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configureCollectionView()
		library = bookStoreManager.getBookTypes()
		configureDataSource()
		applyInitialData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
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
		
		setupNavigationBar()
		
		collectionView.backgroundColor = .systemFill
		collectionView.delegate = self
		view.addSubview(collectionView)
	}
	
	func setupNavigationBar() {
		navigationItem.title = "Книги для души"
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .systemFill
		
		appearance.titleTextAttributes = [
			.foregroundColor: UIColor.white
		]
		
		appearance.largeTitleTextAttributes = [
			.foregroundColor: UIColor.white
		]
		
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
		section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 50, trailing: 0)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [header]
		
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

//MARK: - Settings DiffableDataSource
extension ViewController {
	func configureDataSource() {
		diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? CustomCollectionViewCell else {
				return UICollectionViewCell()
			}
			
			cell.configure(with: self.library[indexPath.section].books[indexPath.row])
			return cell
		}
		
		diffableDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
			if kind == UICollectionView.elementKindSectionHeader {
				let header = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: SectionHeaderView.reuseIdentifier,
					for: indexPath
				) as! SectionHeaderView
				header.configure(text: self.library[indexPath.section].type)
				
				return header
				
			} else if kind == ElementKind.badge {
				let badge = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: BadgeView.reuseIdentifier,
					for: indexPath
				) as! BadgeView
				badge.configureBadge(text: "Новинка")
				badge.isHidden = self.library[indexPath.section].books[indexPath.row].isNew == false
				
				return badge
			}
			return UICollectionReusableView()
		}
	}
	
	func applyInitialData() {
		var snapshot = NSDiffableDataSourceSnapshot<BookType, Book>()
		
		let sections = library
		snapshot.appendSections(sections)
		
		for (sectionIndex, items) in sections.enumerated() {
			snapshot.appendItems(items.books, toSection: library[sectionIndex])
		}
		
		diffableDataSource.apply(snapshot, animatingDifferences: false)
	}
}

//MARK: - CollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let detailVC = DetailViewController()
		detailVC.book = library[indexPath.section].books[indexPath.row]
		navigationController?.pushViewController(detailVC, animated: true)
	}
}
