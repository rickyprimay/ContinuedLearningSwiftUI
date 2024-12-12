//
//  MaskView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 09/12/24.
//

import SwiftUI

struct MaskView: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        ZStack {
            starsView
                .overlay(overlaysView.mask(starsView))
        }
    }
    
    private var overlaysView: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
//                    .foregroundStyle(.yellow)
                    .fill(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geo.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(rating >= index ? .yellow : .gray)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            rating = index
                        }
                    }
            }
        }
    }
}

#Preview {
    MaskView()
}
