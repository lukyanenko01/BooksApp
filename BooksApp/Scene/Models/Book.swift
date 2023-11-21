//
//  Book.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import Foundation

struct Book: Codable, Identifiable {
    var id: Int
    var name: String
    var author: String
    var summary: String
    var genre: String
    var cover_url: String
    var views: String
    var likes: String
    var quotes: String
}

struct GenreSection: Identifiable {
    let id: String
    let title: String
    var books: [Book]
}

