//
//  NewDogView.swift
//  DogBreedFirebase
//
//  Created by Markus on 30.05.24.
//

import SwiftUI

struct NewDogView: View {
    @EnvironmentObject var dataManager: FirebaseDataManager
    @State private var newDog = ""
    
    var body: some View {
           VStack {
               Section {
                   Text("New Dog")
                   TextField("Dog", text: $newDog)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()
               }
               
               Section {
                   Button {
                       dataManager.addDog(dogBreed: newDog)
                       newDog = ""
                   } label: {
                       Text("Save")
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.blue)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
               }
           }
           .padding()
       }
   }


#Preview {
    NewDogView()
}
