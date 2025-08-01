//
//  CarouselView.swift
//  AIChatCourse
//
//  Created by Francisco Cordoba on 31/7/25.
//

import SwiftUI

struct CarouselView<CellView: View, T: Hashable>: View {
    
    var items: [T]
    @ViewBuilder var cellView: (T) -> CellView
    @State private var selection: T?
    
    var body: some View {
        VStack(spacing: 10) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        cellView(item)
                            .scrollTransition(.interactive.threshold(.visible(0.95)), transition: { content, phase in
                                content.scaleEffect(phase.isIdentity ? 1 : 0.9)
                            })
                            .containerRelativeFrame(.horizontal, alignment: .center)
                            .id(item)
                    }
                }
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $selection)
            .onChange(of: items.count, { _, _ in
                updateSelectionIfNeeded()
            })
            .onAppear {
                updateSelectionIfNeeded()
            }
            
            HStack(spacing: 5) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .foregroundStyle(item == selection ? .accent : .secondary.opacity(0.5))
                        .frame(width: 8, height: 8, alignment: .center)
                }
            }
            .animation(.linear, value: selection)
        }
    }
    
    private func updateSelectionIfNeeded() {
        if selection == nil || selection == items.last {
            selection = items.first
        }
    }
}

#Preview {
    CarouselView(items: AvatarModel.mocks,
                 cellView: { item in
        PrimaryCellView(
            title: item.name,
            subtitle: item.characterDescription?.characterDescription,
            imageUrl: Constants.randomImageUrl
        )
    })
}
