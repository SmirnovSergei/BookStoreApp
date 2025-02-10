//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import UIKit

enum Scene {
	case tabBarController
	case viewController
	case sectionProvider
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = UINavigationController(rootViewController: assembly(scene: .tabBarController))
		window?.makeKeyAndVisible()
	}
}

extension SceneDelegate {
	func buildBookStoreManager() -> IBookStoreDataManager {
		let bookTypeManager: IBookTypeManager = BookTypeManager()
		let bookStoreManager = BookStoreDataManager()
		bookStoreManager.addBookTypes(bookTypeManager.getBookTypes())
		
		return bookStoreManager
	}
	
	func assembly(scene: Scene) -> UIViewController {
		switch scene {
		case .tabBarController:
			return TabBarController()
		case .viewController:
			let viewController = ViewController()
			viewController.bookStoreManager = buildBookStoreManager()
			return viewController
		case .sectionProvider:
			return MultipleSectionsViewController()
		}
	}
}
