//
//  HapticsVibrationView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 09/12/24.
//

import SwiftUI

class HapticManager: ObservableObject {
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}

struct HapticsVibrationView: View {
    
    @StateObject var hm = HapticManager()
    
    var body: some View {
        VStack(spacing: 20){
            Button {
                hm.notification(type: .success)
            } label: {
                Text("Success")
            }
            Button {
                hm.notification(type: .warning)
            } label: {
                Text("Warning")
            }
            Button {
                hm.notification(type: .error)
            } label: {
                Text("Error")
            }
            Divider()
            Button {
                hm.impact(style: .soft)
            } label: {
                Text("soft")
            }
            Button {
                hm.impact(style: .light)
            } label: {
                Text("light")
            }
            Button {
                hm.impact(style: .medium)
            } label: {
                Text("medium")
            }
            Button {
                hm.impact(style: .rigid)
            } label: {
                Text("rigid")
            }
            Button {
                hm.impact(style: .heavy)
            } label: {
                Text("heavy")
            }
        }
    }
}

#Preview {
    HapticsVibrationView()
}
