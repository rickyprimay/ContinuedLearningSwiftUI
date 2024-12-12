//
//  CoreDataView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 12/12/24.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores{ (description, error ) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("SUCCESSFULLY LOADED CORE DATA!")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do{
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching. \(error)")
        }
        
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error Saving. \(error)")
        }
    }
}

struct CoreDataView: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                TextField("Add Fruit here ...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button{
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Add")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                List{
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataView()
}
