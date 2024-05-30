//
//  DogListView.swift
//  DogBreedFirebase
//
//  Created by Markus on 30.05.24.
//

import SwiftUI

struct DogListView: View {
    @EnvironmentObject var dataManager: FirebaseDataManager
    @State private var showPopup = false
    
    var body: some View {
        NavigationView{
            List(dataManager.dogs, id: \.id) { dog in
                Text(dog.breed)
            }
            .navigationTitle("Dogs")
            .navigationBarItems(trailing: Button(action: {
                showPopup.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showPopup) {
                NewDogView()
            }
        }
    }
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDataManager = FirebaseDataManager()
        mockDataManager.dogs = [
            Dog(id: "1", breed: "PitBull"),
            Dog(id: "2", breed: "Beagle")
        ]
        
        return DogListView()
            .environmentObject(mockDataManager)
    }
}
