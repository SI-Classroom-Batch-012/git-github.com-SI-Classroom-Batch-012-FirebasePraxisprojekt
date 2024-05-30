//
//  FirebaseDataManager.swift
//  DogBreedFirebase
//
//  Created by Markus on 30.05.24.
//

import SwiftUI
import Firebase

class FirebaseDataManager : ObservableObject {
    @Published var dogs: [Dog] = []
    
    init() {
        fetchDogs()
    }
    
    func fetchDogs() {
        dogs.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Dogs")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print (error!.localizedDescription)
                return
                
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let breed = data["breed"] as? String ?? ""
                    
                    let dog = Dog(id: id, breed: breed)
                    self.dogs.append(dog)
                }
            }
        }
    }
    
    func addDog(dogBreed: String) {
        let db = Firestore.firestore()
        let newId = UUID().uuidString
        let ref = db.collection("Dogs").document(newId)
        ref.setData(["breed": dogBreed, "id" : newId]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.fetchDogs()
            }
        }
    }
}
