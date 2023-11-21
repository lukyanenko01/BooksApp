//
//  RemoteConfigData.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import Foundation

struct RemoteConfigData: Codable {
    var books: [Book]
    var top_banner_slides: [TopBannerSlide]
    var you_will_like_section: [Int]
}
