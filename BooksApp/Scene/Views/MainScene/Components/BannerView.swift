//
//  BannerView.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import SwiftUI

struct BannerView: View {
    var slide: TopBannerSlide

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: slide.cover)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .scaledToFill()
        }
        .frame(width: 350, height: 200)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


