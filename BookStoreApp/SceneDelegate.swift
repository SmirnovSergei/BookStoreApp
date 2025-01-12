//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		
		window?.rootViewController = ViewController()
		window?.makeKeyAndVisible()
	}
}
