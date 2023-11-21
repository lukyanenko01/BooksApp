//
//  MainPage.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import SwiftUI

struct MainPage: View {
    @StateObject var viewModel: MainPageViewModel

    var body: some View {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    viewModel.startAutoScroll()
                }            }
            .onDisappear {
                viewModel.stopAutoScroll()
            }

            ScrollView {
                ForEach(viewModel.sections) { section in
                    GenreSectionView(genreSection: section)
                        .onTapGesture {
                            print("TAP")
                        }
                }
            }
        }
        .background(Color.background)
    }
}

