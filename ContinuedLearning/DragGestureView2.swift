//
//  DragGestureView2.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 04/12/24.
//

import SwiftUI

struct DragGestureView2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            MySignUpView(isExpanded: endingOffsetY < 0)
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            if currentDragOffsetY < -150 {
                                endingOffsetY = -startingOffsetY
                            } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                endingOffsetY = 0
                            }
                            currentDragOffsetY = 0
                        }
                )
            
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestureView2()
}

struct MySignUpView: View {
    var isExpanded: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: isExpanded ? "chevron.down" : "chevron.up")
                .font(.title)
                .bold()
                .padding(.top)
                .background()
            
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. This is my favorite SwiftUI Learning and i recommend to all of myu friend to be a iOS Developer")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Create an Account")
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}
