//
//  HashableView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 09/12/24.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableView: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "One"),
        MyCustomModel(title: "Two"),
        MyCustomModel(title: "Three"),
        MyCustomModel(title: "Four"),
        MyCustomModel(title: "Five"),
        MyCustomModel(title: "Six"),
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
//                ForEach(data) { item in
//                    Text(item.title)
//                        .font(.headline)
//                }
//                ForEach(data, id: \.self) { item in
//                    Text(item)
//                        .font(.headline)
//                }
            }
        }
    }
}

#Preview {
    HashableView()
}
