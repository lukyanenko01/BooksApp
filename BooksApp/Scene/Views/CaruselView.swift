//
//  CaruselView.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 22.11.2023.
//

import SwiftUI

struct CarouselView: View {
    @Binding var currentIndex: Int 
    @GestureState private var dragOffset: CGFloat = 0
    var imageUrls: [URL]
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<imageUrls.count, id: \.self) { index in
                    AsyncImage(url: imageUrls[index]) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray // Замените на ваш плейсхолдер
                    }
                    .scaledToFit()
                    .frame(width: currentIndex == index ? 220 : 200, height: 250)
                    .cornerRadius(25)
                    .opacity(currentIndex == index ? 1 : 0.5)
                    .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                    .offset(x: CGFloat(index - currentIndex) * 200 + dragOffset, y: 0)
                    .zIndex(currentIndex == index ? 1 : 0)
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragOffset, body: { (value, state, transaction) in
                        state = value.translation.width
                    })
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            currentIndex = max(0, currentIndex - 1)
                        } else if value.translation.width < -threshold {
                            currentIndex = min(imageUrls.count - 1, currentIndex + 1)
                        }
                    })
            )
        }
    }
}
