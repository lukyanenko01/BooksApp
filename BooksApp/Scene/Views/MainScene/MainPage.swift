//
//  MainPage.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import SwiftUI

struct MainPage: View {
    @StateObject var viewModel: MainPageViewModel
    @State private var selectedBookId: Int = 0
    @State private var isLinkActive: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                TabView(selection: $viewModel.selectedIndex) {
                    ForEach(viewModel.topBannerSlides) { slide in
                        if let url = URL(string: slide.cover) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 350, height: 200)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .tag(slide.id)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 200)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        viewModel.startAutoScroll()
                    }
                }
                .onDisappear {
                    viewModel.stopAutoScroll()
                }
                
                ScrollView {
                    ForEach(viewModel.sections) { section in
                        GenreSectionView(genreSection: section, selectedBookId: $selectedBookId, isLinkActive: $isLinkActive)
                            .onTapGesture {
                                self.selectedBookId = section.books.first?.id ?? 0
                                self.isLinkActive = true
                            }
                    }
                }
                .background(Color.background)
                .navigationTitle("Main Page")
                .navigationBarHidden(true)
            }
            .background(
                NavigationLink(destination: DetailsPage(viewModel: DetailsPageViewModel(), selectedBookId: $selectedBookId), isActive: $isLinkActive) {
                    EmptyView()
                })
        }
        
    }
}
            
