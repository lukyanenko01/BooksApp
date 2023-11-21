//
//  GenreSectionView.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import SwiftUI

struct GenreSectionView: View {
    var genreSection: GenreSection

    var body: some View {
        VStack(alignment: .leading) {
            Text(genreSection.title)
                .font(.headline)
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(genreSection.books) { book in
                        BookView(book: book)
                            .frame(width: 130, height: 210)
                    }
                }
            }
        }
    }
}
