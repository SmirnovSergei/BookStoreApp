//
//  TabBarController.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 10.02.2025.
//

import UIKit

enum TabBarItem {
	case home
	case search
	
	var title: String {
		switch self {
		case .home:
			return "Home"
		case .search:
			return "Search"
		}
	}
	
	var icon: UIImage? {
		switch self {
		case .home:
			return UIImage(systemName: "house.fill")
		case .search:
			return UIImage(systemName: "magnifyingglass")
		}
	}
}
final class TabBarController: UITabBarController {
	
	private let dataSource: [TabBarItem] = [.home, .search]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		buildTabBarComponents()
		setupTabBar()
	}
}

//MARK: - Settings View
private extension TabBarController {
	func buildTabBarComponents() {
		viewControllers = dataSource.map {
			switch $0 {
			case .home:
				let viewController = ViewController()
				viewController.bookStoreManager = buildBookStoreManager()
				return UINavigationController(rootViewController: viewController)
			case .search:
				return UINavigationController(rootViewController: MultipleSectionsViewController())
			}
		}
	}
	
	func setupTabBar() {
		let appearance = UITabBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .black
		
		appearance.stackedLayoutAppearance.normal.iconColor = .gray
		appearance.stackedLayoutAppearance.selected.iconColor = .white
		appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
		appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
		
		tabBar.standardAppearance = appearance
		tabBar.scrollEdgeAppearance = appearance
		
		viewControllers?.enumerated().forEach { index, viewController in
			viewController.tabBarItem.title = dataSource[index].title
			viewController.tabBarItem.image = dataSource[index].icon
		}
	}
}

extension TabBarController {
	func buildBookStoreManager() -> IBookStoreDataManager {
		let bookTypeManager: IBookTypeManager = BookTypeManager()
		let bookStoreManager = BookStoreDataManager()
		bookStoreManager.addBookTypes(bookTypeManager.getBookTypes())
		
		return bookStoreManager
	}
}
