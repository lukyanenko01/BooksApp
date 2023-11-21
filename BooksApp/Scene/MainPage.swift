//
//  MainPage.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import SwiftUI

struct MainPage: View {
    @State private var selectedIndex = 0
    let books = [
        Book(id: 1, coverImage: "cover1"),
        Book(id: 2, coverImage: "cover1"),
        Book(id: 3, coverImage: "cover1")
    ]
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(books, id: \.id) { book in
                BookView(book: book)
                    .tag(book.id)
                    .onTapGesture {
                        // Логіка для переходу на Details screen з обраною книгою
                    }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 200)
        .onReceive(timer) { _ in
            withAnimation {
                selectedIndex = (selectedIndex + 1) % books.count
            }
        }
    }
}

#Preview {
    MainPage()
}

struct Book {
    var id: Int
    var title: String?
    var coverImage: String
}

// View для відображення книги
struct BookView: View {
    var book: Book

    var body: some View {
        VStack {
            Image(book.coverImage)
                .resizable()
                .scaledToFill()
        }
        .frame(width: 350, height: 200)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


