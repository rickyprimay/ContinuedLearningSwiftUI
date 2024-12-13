//
//  WeakSelfView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 13/12/24.
//

import SwiftUI

struct WeakSelfView: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination:WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
                .padding(.trailing)
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondViewModel()
    
    var body: some View {
        Text("Second View")
            .font(.largeTitle)
            .foregroundStyle(.red)
        
        if let data = vm.data {
            Text(data)
        }
    }
}

class WeakSelfSecondViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init(){
        print("Initialize now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("Deinitialize now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "New Data!!!"
        }
        
    }
    
}

#Preview {
    WeakSelfView()
}
