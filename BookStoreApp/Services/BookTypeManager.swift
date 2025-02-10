//
//  BookTypeManager.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import Foundation

protocol IBookTypeManager {
	func getBookTypes() -> [BookType]
}

class BookTypeManager {}

extension BookTypeManager: IBookTypeManager {
	func getBookTypes() -> [BookType] {
		[
			BookType(type: "Выбор редакции", books: [
				Book(image: "book1", title: "Подводное бормотание", id: 0, isNew: true),
				Book(image: "book2", title: "Один в поле воен",  id: 1, isNew: true),
				Book(image: "book3", title: "Мне ничего не жаль", id: 2),
				Book(image: "book4", title: "Кто ты воин?", id: 3, isNew: true),
				Book(image: "book5", title: "Можно я с тобой?", id: 4)
			]),
			BookType(type: "Новинки в подписке", books: [
				Book(image: "book6", title: "Мы все сможем", id: 5),
				Book(image: "book7", title: "Мотивация", id: 6, isNew: true),
				Book(image: "book8", title: "Деградация", id: 7, isNew: true),
				Book(image: "book9", title: "Параллельные прямые", id: 8)
			]),
			BookType(type: "Бестселлеры", books: [
				Book(image: "book10", title: "Как управлять вселенной, не привлекая внимания санитаров", id: 9, isNew: true),
				Book(image: "book11", title: "Кальян из велосипедного насоса", id: 10),
				Book(image: "book12", title: "Гарри Поттер и форма 6-НДФЛ", id: 11),
				Book(image: "book13", title: "Как понять женщину", id: 12, isNew: true),
				Book(image: "book14", title: "Как правильно похудеть", id: 13)
			])
		]
	}
}
