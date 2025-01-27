//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import UIKit

enum Scene {
	case viewController
	case sectionProvider
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		
		let viewController = ViewController()
		viewController.bookStoreManager = buildBookStoreManager()
		
		window?.rootViewController = assembly(scene: .sectionProvider)
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
		case .viewController:
			return ViewController()
		case .sectionProvider:
			return MultipleSectionsViewController()
		}
	}
}
