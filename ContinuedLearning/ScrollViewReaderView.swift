//
//  ScrollViewReaderView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 05/12/24.
//

import SwiftUI

struct ScrollViewReaderView: View {
    
    @State var scrollToIndex: Int = 0
    
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter a $ here ...", text: $textFieldText)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
            }
            
            ScrollView {
                ScrollViewReader{ proxy in
                    ForEach(0..<50) { index in
                        Text("this is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex, perform: { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .center)
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderView()
}
