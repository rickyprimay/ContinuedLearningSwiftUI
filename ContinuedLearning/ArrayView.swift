//
//  ArrayView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 09/12/24.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers(){
        let user1 = UserModel(name: "Ricky", points: 5, isVerified: true)
        let user2 = UserModel(name: "Prima", points: 0, isVerified: false)
        let user3 = UserModel(name: "Yudha", points: 25, isVerified: true)
        let user4 = UserModel(name: "Putra", points: 15, isVerified: false)
        let user5 = UserModel(name: "Anto", points: 20, isVerified: true)
        let user6 = UserModel(name: "Rama", points: 60, isVerified: false)
        let user7 = UserModel(name: "Nopal", points: 43, isVerified: true)
        let user8 = UserModel(name: "Yutase", points: 55, isVerified: false)
        let user9 = UserModel(name: "Adit", points: 1, isVerified: true)
        let user10 = UserModel(name: "Aria", points: 100, isVerified: false)
        
        self.dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])
    }
    
    func updateFilteredArray() {
        //sort
        /*
        let sortedArray = dataArray.sorted { (user1, user2) -> Bool in
            return user1.points > user2.points
        }
        filteredArray = dataArray.sorted(by: { $0.points > $1.points})
         */
        
        //filter
        /*
        filteredArray = dataArray.filter({ (user) -> Bool in
            return user.isVerified
        })
        
        filteredArray = dataArray.filter({ $0.isVerified })
        */
        
        //map
        /*
        mappedArray = dataArray.map({ (user) -> String in
            return user.name
        })
        
        mappedArray = dataArray.map({ $0.name })
         */
        
        let sort = dataArray.sorted(by: { $0.points > $1.points })
        let filter = dataArray.filter({ $0.isVerified })
        let map = dataArray.compactMap({ $0.name })
        
        let mappedArray = dataArray
            .sorted(by: { $0.points > $1.points })
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
        
    }
    
}

struct ArrayView: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack{
//                            Text("Poitns: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArrayView()
}
