//
//  BookTypeModel.swift
//  BookStoreApp
//
//  Created by Сергей Смирнов on 12.01.2025.
//

import Foundation

struct BookType {
	let type: String
	let books: [Book]
}

struct Book {
	let image: String
	let title: String
	var isNew = false
}

extension BookType: Hashable, Equatable {}
extension Book: Hashable, Equatable {}
