//
//  BookStoreDataManager.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import Foundation

protocol IBookStoreDataManager {
	func addBookTypes(_ bookTypes: [BookType])
	func isEmpty() -> Bool
	func getCount() -> Int
	func getBookTypes() -> [BookType]
	func getBookWithID(_ id: Int) -> Book?
}

class BookStoreDataManager: IBookStoreDataManager {
	private var bookTypes: [BookType] = []
	
	func addBookTypes(_ bookTypes: [BookType]) {
		self.bookTypes.append(contentsOf: bookTypes)
	}
	
	func isEmpty() -> Bool {
		bookTypes.isEmpty
	}
	
	func getCount() -> Int {
		bookTypes.count
	}
	
	func getBookTypes() -> [BookType] {
		bookTypes
	}
	
	func getBookWithID(_ id: Int) -> Book? {
		var foundedBook: Book!
		
		for bookType in bookTypes {
			for book in bookType.books {
				if book.id == id {
					foundedBook = book
				}
			}
		}
		return foundedBook
	}
}
