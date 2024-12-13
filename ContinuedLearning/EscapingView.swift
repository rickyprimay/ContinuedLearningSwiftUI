//
//  EscapingView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 13/12/24.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    @Published var isLoading: Bool = false
    
    func getData() {
        isLoading = true
        downloadData5 { [weak self] (returnedResult) in
            DispatchQueue.main.async {
                self?.text = returnedResult.data
                self?.isLoading = false
            }
        }
    }
    
    func downloadData() -> String {
        
        
        return "New Data"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> ()) {
        completionHandler("New Data!")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New Data!")
        }
        
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingView: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        VStack {
            if vm.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else if vm.text != "Hello"{
                Text(vm.text)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            } else {
                Text(vm.text)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        vm.getData()
                    }
            }
        }
        .padding()
    }
}

#Preview {
    EscapingView()
}
