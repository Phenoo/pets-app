//
//  CustomCarousel.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 24/09/2024.
//

import SwiftUI

struct CustomCarousel<Content: View, Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    var config: Config
    @Binding var selection: Data.Element.ID?
    var data: Data
    @ViewBuilder var content: (Data.Element) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.horizontal) {
                HStack(spacing: config.spacing){
                    ForEach(data) { item in
                        ItemView(item)
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, max((size.width - config.cardWidth) / 2, 0))
            .scrollPosition(id: $selection)
            
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    func ItemView(_ item: Data.Element) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            let progress = minX / (config.cardWidth + config.spacing)
            let minimumCardWidth = config.minimumCardWidth
            let diffWidth = config.cardWidth - minimumCardWidth
            let reducingWidth = progress * diffWidth
            
            let cappedWidth = min(reducingWidth, diffWidth)
            
            let resizedFrameWidth = size.width - (minX > 0 ? cappedWidth: min(-cappedWidth, diffWidth))
            
            let negativeProgress = max(-progress, 0)
            
            let opacityValue = config.opacityValue * abs(progress)

            let scaleValue = config.scaleValue * abs(progress)

            
            content(item)
                .frame(width: size.width, height: size.height)
                .frame(width: resizedFrameWidth)
                .opacity(config.hasOpacity ? 1 - opacityValue: 1)
                .scaleEffect(config.hasScale ? 1 - scaleValue: 1)
                .clipShape(.rect(cornerRadius: config.cornerRadius))
                .mask {
                    let hasScale = config.hasScale
                    let scaleHeight = (1 - scaleValue) * size.height
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .frame(height: hasScale ? scaleHeight : size.height)
                    
                }
                .offset(x: -reducingWidth)
                .offset(x: min(progress, 1) * diffWidth)
                .offset(x: negativeProgress * diffWidth)
        }
        .frame(width: config.cardWidth)
    }
    
    
    struct Config {
        var hasOpacity: Bool = false
        var opacityValue: CGFloat = 0.5
        var hasScale: Bool = false
        var scaleValue: CGFloat = 0.2
        var cornerRadius: CGFloat = 10
        var cardWidth: CGFloat = 150
        var spacing: CGFloat = 10
        var minimumCardWidth: CGFloat = 40
        
    }
    
}

struct CustomHome: View {
    @State private var activeID: UUID?
    var body: some View {
        NavigationStack {
            VStack {
                CustomCarousel(config: .init(hasOpacity: true, hasScale: true, cardWidth: 200, minimumCardWidth: 30), selection: $activeID, data: images) { item in
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(height: 120)
            }
        }
    }
}

#Preview {
    CustomHome()
}
