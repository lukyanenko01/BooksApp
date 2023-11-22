//
//  BookView.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import SwiftUI

struct BookView: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: book.cover_url) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 150)
                .cornerRadius(10)
                .shadow(radius: 16)
            }
            Text(book.name)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}


