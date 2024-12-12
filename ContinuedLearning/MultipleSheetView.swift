//
//  MultipleSheetView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 09/12/24.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}



struct MultipleSheetView: View {
    
    @State var selectedModel: RandomModel?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(0..<50) { index in
                    Button{
                        selectedModel = RandomModel(title: "Model \(index)")
                    } label: {
                        Text("Button \(index)")
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 50)
                            .background(index % 2 == 0 ? .red : .blue)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .padding()
                    }
                    
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetView()
}
