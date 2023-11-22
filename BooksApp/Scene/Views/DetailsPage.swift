//
//  DetailsPage.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import SwiftUI

class DetailsPageViewModel: ObservableObject {
    @Published var bookDetails: [Book] = []
    @Published var recommendedBooks: [Book] = []
    
    func fetchDetails(for bookId: Int) {
        NetworkManager.shared.fetchBooks { [weak self] data in
            DispatchQueue.main.async {
                guard let data = data else { return }
                if let book = data.books.first(where: { $0.id == bookId }) {
                    self?.bookDetails = [book]
                }
                self?.recommendedBooks = data.books.filter { data.you_will_like_section.contains($0.id) }
            }
        }
    }
}

struct DetailsPage: View {
    @ObservedObject var viewModel: DetailsPageViewModel
    @Binding var selectedBookId: Int // Теперь это Binding переменная

    var body: some View {
        VStack {
            // Карусель изображений
            if !viewModel.bookDetails.isEmpty {
                CarouselView(currentIndex: $selectedBookId, imageUrls: viewModel.bookDetails.map { URL(string: $0.cover_url)! })
                    .frame(height: 300)
            }
            
            // Рекомендованные книги
            VStack {
                HStack {
                    if let selectedBook = viewModel.bookDetails.first(where: { $0.id == selectedBookId }) {
                            // Используйте selectedBook для отображения деталей книги
                            Text(selectedBook.author)
                            Text(selectedBook.summary)
                            // и так далее...
                        }
                }
            }
            .background(Color.white)
        }
        .onAppear {
            viewModel.fetchDetails(for: selectedBookId)
        }
    }
}

//struct DetailsPage: View {
//    @ObservedObject var viewModel: DetailsPageViewModel
//    let bookId: Int
//    
//    var body: some View {
//        VStack {
//            VStack {
//                CaruselView()
//                ForEach(viewModel.bookDetails, id: \.id) { book in
//                    Text(book.cover_url) // Изображение книги
//                    Text(book.author) // Автор
//                    Text(book.summary) // Описание
//                }
//            }
//            .background(Color.backgroundDetails)
//            ScrollView(.horizontal) {
//                Text("You will also like")
//                    .font(.headline)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(viewModel.recommendedBooks, id: \.id) { book in
//                            BookView(book: book)
//                        }
//                    }
//                }
//            }
//            .background(Color.white)
//
//        }
//        
//
//        .onAppear {
//            viewModel.fetchDetails(for: bookId)
//        }
//    }
//}
