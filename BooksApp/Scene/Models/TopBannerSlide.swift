//
//  TopBannerSlide.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import Foundation

struct TopBannerSlide: Codable, Identifiable {
    var id: Int
    var book_id: Int
    var cover: String
}
