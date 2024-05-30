//
//  DogBreedFirebaseApp.swift
//  DogBreedFirebase
//
//  Created by Markus on 28.05.24.
//

import SwiftUI
import Firebase

@main
struct DogBreedFirebaseApp: App {
    @StateObject var dataManager = FirebaseDataManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            DogListView()
                .environmentObject(dataManager)
        }
    }
}
