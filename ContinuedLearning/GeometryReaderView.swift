//
//  GeometryReaderView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 08/12/24.
//

import SwiftUI

struct GeometryReaderView: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geo) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        
//        GeometryReader{ geo in
//            HStack(spacing: 0){
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: geo.size.width * 0.6666)
//                Rectangle()
//                    .fill(.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
}

#Preview {
    GeometryReaderView()
}
