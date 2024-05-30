//
//  ContentView.swift
//  DogBreedFirebase
//
//  Created by Markus on 28.05.24.
//

import SwiftUI
import Firebase

struct WelcomeScreenView: View {
    
    @State private var email = ""
    @State private var isPasswordVisible = false
    @State private var password = ""
    @State private var userIsLoggedin = false
    
    var body: some View {
        if userIsLoggedin {
            DogListView()
        }
        else {
            welcomeScreen
        }
    }
    
    var welcomeScreen: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.mint, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                )
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack(spacing: 20){
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)
                    .shadow(radius: 25)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty){
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height:1)
                    .foregroundColor(.white)
                
                ZStack(alignment: .trailing) {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .bold()
                            .placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                    } else {
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: password.isEmpty) {
                                Text("Password")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 10)
                }
                
                Rectangle()
                    .frame(width: 350, height:1)
                    .foregroundColor(.white)
                
                Button{
                    register()
                } label: {
                    Text("Sign up")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.blue)
                        )
                        .foregroundColor(.white)
                }
                .padding()
                .offset(y: 100)
                
                Button{
                    login()
                } label:{
                    Text("Already have an account? Login")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding(.top)
                .offset(y: 110)
            }
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener {auth, user in
                    if user != nil {
                        userIsLoggedin.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {result, error  in
            if error != nil {
                print (error!.localizedDescription)
            }
        }
    }
}

#Preview {
    WelcomeScreenView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
