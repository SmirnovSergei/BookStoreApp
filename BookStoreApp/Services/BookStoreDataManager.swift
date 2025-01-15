//
//  BookStoreDataManager.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import Foundation

protocol IBookStoreDataManager {
	func addBookTypes(_ bookTypes: [BookType])
	func getBookTypes() -> [BookType]
//	func getBooksInBookType(_ bookType: String) -> [Book]
}

class BookStoreDataManager: IBookStoreDataManager {
	private var bookTypes: [BookType] = []
	
	func addBookTypes(_ bookTypes: [BookType]) {
		self.bookTypes.append(contentsOf: bookTypes)
	}
	
	func getBookTypes() -> [BookType] {
		bookTypes
	}
	
//	func getBooksInBookType(_ bookType: String) -> [Book] {
//
//	}
}
