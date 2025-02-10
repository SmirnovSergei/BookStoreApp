//
//  MultipleSectionsViewController.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 27.01.2025.
//

import UIKit

final class MultipleSectionsViewController: UIViewController {
	
	private let reuseIdentifier = "reuseIdentifier"
	private var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configureCollectionView()
	}
}

private extension MultipleSectionsViewController {
	func setupView() {
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		
		collectionView.register(
			MultipleSectionHeaderView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: MultipleSectionHeaderView.reuseIdentifier
		)
		
		collectionView.backgroundColor = .black
		collectionView.dataSource = self
		
		view.backgroundColor = .black
		view.addSubview(collectionView)
		
		setupNavigationBar()
	}
	
	func setupNavigationBar() {
		navigationItem.title = "Поиск"
		navigationController?.navigationBar.prefersLargeTitles = false

	}
}

//MARK: - Settings Layout
private extension MultipleSectionsViewController {
	func createLayout() -> UICollectionViewLayout {
		
		return UICollectionViewCompositionalLayout { sectionIndex, environment in
			if sectionIndex == 0 {
				return self.createTopSection()
			} else if sectionIndex == 1 {
				return self.createMiddleSection()
			} else {
				return self.createBottomSection()
			}
		}
	}
	
	
	func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let headerSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(50)
		)
		
		let header = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top
		)
		header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
		
		return header
	}
	
	func createTopSection() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(110),
			heightDimension: .absolute(110)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .estimated(1),
			heightDimension: .absolute(110)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior	= .continuous
		section.boundarySupplementaryItems = [createHeader()]
		
		return section
	}
	
	func createMiddleSection() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(160),
			heightDimension: .fractionalHeight(1)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .estimated(1),
			heightDimension: .absolute(180)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [createHeader()]
		
		return section
	}
	
	func createBottomSection() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(0.37)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [createHeader()]
		
		return section
	}
	
	func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

extension MultipleSectionsViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		3
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		7
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

		if indexPath.section == 0 {
			cell.backgroundColor = .systemMint
			cell.layer.cornerRadius = cell.frame.width / 2
		} else if indexPath.section == 1 {
			cell.backgroundColor = .systemPurple
			cell.layer.cornerRadius = 10
		} else {
			cell.backgroundColor = .systemCyan
			cell.layer.cornerRadius = 10
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MultipleSectionHeaderView.reuseIdentifier, for: indexPath) as? MultipleSectionHeaderView else {
			
			return UICollectionReusableView()
		}
		header.configure(text: "Section \(indexPath.section + 1)")
		return header
	}
}
