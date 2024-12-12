//
//  MagnificationGesture.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 04/12/24.
//

import SwiftUI

struct MagnificationGestureView: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    @State var radius: CGFloat = 0
    
    var body: some View {
        
        VStack {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                Text("rickyprimay")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .cornerRadius(radius)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                            radius = 10
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                                radius = 0
                            }
                        }
                )
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption from my photo!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .font(.title)
//            .padding(48)
//            .background(.red)
//            .cornerRadius(10)
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged{ value in
//                        currentAmount = value - 1
//                    }
//                    .onEnded { value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
    }
}

#Preview {
    MagnificationGestureView()
}
