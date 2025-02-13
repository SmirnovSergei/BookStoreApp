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
		case .home: return "Home"
		case .search: return "Search"
		}
	}
	
	var icon: UIImage? {
		switch self {
		case .home: return UIImage(systemName: "house.fill")
		case .search: return UIImage(systemName: "magnifyingglass")
		}
	}
	
	static let allTabBarItems = [home, search]
}

final class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBar()
	}
}

//MARK: - Settings View
private extension TabBarController {
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
		
		let controllers: [UINavigationController] = TabBarItem.allTabBarItems.map { item in
			setupNavigationBar(item)
		}

		setViewControllers(controllers, animated: true)
	}
	
	func setupNavigationBar(_ item: TabBarItem) -> UINavigationController {
		let navController = UINavigationController()
		
		navController.navigationBar.tintColor = .white
		
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .black
		
		appearance.titleTextAttributes = [
			.foregroundColor: UIColor.white
		]
		
		appearance.largeTitleTextAttributes = [
			.foregroundColor: UIColor.white
		]
		
		navController.navigationBar.standardAppearance = appearance
		navController.navigationBar.scrollEdgeAppearance = appearance
		
		navController.tabBarItem.title = item.title
		navController.tabBarItem.image = item.icon
		
		return navController
	}
}
