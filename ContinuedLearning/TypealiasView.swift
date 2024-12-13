//
//  TypealiasView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 13/12/24.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TvModel = MovieModel

struct TypealiasView: View {
    
    @State var item: MovieModel = MovieModel(title: "Spiderman: Home Coming", director: "Marvel", count: 20)
    
    @State var items: TvModel = TvModel(title: "Game of Thrones", director: "HBO", count: 20)
    
    var body: some View {
        VStack {
            Text(items.title)
            Text(items.director)
            Text("\(items.count)")
        }
    }
}

#Preview {
    TypealiasView()
}
