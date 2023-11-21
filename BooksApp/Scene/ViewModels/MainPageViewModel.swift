//
//  MainPageViewModel.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import SwiftUI

class MainPageViewModel: ObservableObject {
    @Published var topBannerSlides: [TopBannerSlide] = []
    @Published var sections: [GenreSection] = [] 
    @Published var selectedIndex = 0
    private var timer: Timer?
    
    init() {
        fetchTopBannerSlides()
        fetchBookSections()
        startAutoScroll()
    }
    
    private func fetchBookSections() {
        NetworkManager.shared.fetchBooks { [weak self] data in
            DispatchQueue.main.async {
                let groupedBooks = Dictionary(grouping: data?.books ?? [], by: { $0.genre })
                let sortedSections = groupedBooks.map { GenreSection(id: $0.key, title: $0.key, books: $0.value) }
                self?.sections = sortedSections.sorted { $0.title < $1.title }
            }
        }
    }

    
    private func fetchTopBannerSlides() {
        NetworkManager.shared.fetchBooks { [weak self] data in
            DispatchQueue.main.async {
                self?.topBannerSlides = data?.top_banner_slides ?? []
                if !(self?.topBannerSlides.isEmpty ?? true) {
                    self?.selectedIndex = self?.topBannerSlides.first?.id ?? 0
                }
            }
        }
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            guard let self = self, !self.topBannerSlides.isEmpty else { return }
            let nextIndex = (self.selectedIndex + 1) % self.topBannerSlides.count
            withAnimation {
                self.selectedIndex = nextIndex
            }
        }
    }
    
    func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
}

