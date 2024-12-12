//
//  RotationGestureView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 04/12/24.
//

import SwiftUI

struct RotationGestureView: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(50)
            .background(.blue)
            .cornerRadius(10)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged{ value in
                        angle = value
                    }
                    .onEnded{ value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

#Preview {
    RotationGestureView()
}
