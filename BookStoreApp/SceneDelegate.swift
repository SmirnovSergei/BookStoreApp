//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	private let allTabBarItems = TabBarItem.allTabBarItems
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		
		let tabBarController = TabBarController()
		
		tabBarController.viewControllers?.enumerated().forEach { index, vc in
			guard let navVC = vc as? UINavigationController else { return }
			pushViewController(index: index, controller: navVC)
		}
		
		window?.rootViewController = UINavigationController(rootViewController: tabBarController)
		window?.makeKeyAndVisible()
	}
}

extension SceneDelegate {
	func pushViewController(index: Int, controller: UINavigationController) {
		let bookStoreManager: IBookStoreDataManager = BookStoreDataManager()
		
		if bookStoreManager.isEmpty() {
			let bookStoreRepository = BookTypeManager()
			let bookTypes = bookStoreRepository.getBookTypes()
			bookStoreManager.addBookTypes(bookTypes)
		}
		
		switch allTabBarItems[index] {
		case .home:
			let homeVC = ViewController(manager: bookStoreManager)
			controller.pushViewController(homeVC, animated: false)
		case .search:
			let searchVC = MultipleSectionsViewController()
			controller.pushViewController(searchVC, animated: false)
		}
	}
}
