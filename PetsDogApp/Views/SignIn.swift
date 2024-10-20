//
//  SignIn.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 19/09/2024.
//

import SwiftUI

struct SignIn: View {
    
    @State private var selectedText: String = "User name"
    @State private var selectedTextEmail: String = "Email"
    @State private var selectedTextPassword: String = "Password"
    @State private var selectedTextPhone: String = "Phone"

    
    @State private var height: CGFloat = 1000

    @State private var heightanimate: CGFloat = .infinity

    @State private var animate: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customGreen
                VStack(spacing: 40){
                    
                        VStack {
                            BodyTextView(size: 35, title: "Sign Up")
                                .fontWeight(.semibold)
                            TextView(size: 16, title: "Sign up as pet owner")
                                .fontWeight(.medium)
                        }
                        
                        VStack(spacing: 20){
                            TextField("User name", text: $selectedText)
                                .customTextFieldStyle()

                            
                            TextField("User name", text: $selectedTextEmail)
                                .customTextFieldStyle()

                            
                            TextField("User name", text: $selectedTextPassword)
                                .customTextFieldStyle()
                            
                            TextField("User name", text: $selectedTextPhone)
                                .customTextFieldStyle()
                            
                            Button {
                                animate = true
                        } label: {
                            TextView(size: 16, title:  "Let me in")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.customGreen)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.customPink)
                                }
                        }
                    
                           
                            
                            AuthButton(title: "Sign up with Facebook", image: "")
                            AuthButton(title: "Sign up with Google", image: "")

                            HStack {
                                TextView(size: 16, title: "Already have an account?")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.gray)
                                NavigationLink(destination: Text("")) {
                                    TextView(size: 16, title: "Sign up")
                                        .foregroundStyle(Color.black)
                                        .fontWeight(.bold)
                                }
                            }
                            
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundStyle(Color.customGreen)
                    .background{
                        Rectangle()
                            .fill(.white)
                            .clipShape(
                                .rect(topLeadingRadius: 20, topTrailingRadius: 20)
                            )
                           
                    }
                
                    .offset(y: height)

                
            }
            .onAppear {
                withAnimation(.bouncy(duration: 1)){
                    height = 0
                }
                
                withAnimation(.smooth(duration: 3)){
                    heightanimate = 0
                }
            }
            .foregroundStyle(.white)
            .ignoresSafeArea(edges: [.bottom])
            .toolbarBackground(Color.customGreen, for: .navigationBar, .tabBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .fullScreenCover(isPresented: $animate) {
                SignUpStepsView()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    BodyTextView(size: 32, title: "Petazy")
                        .foregroundStyle(Color.customPink)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .fontWeight(.semibold)
                            .padding(8)
                            .font(.subheadline)
                            .foregroundStyle(Color.customYellow)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            }
                    }
                }
            }
            
        }
    }
}


struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.customGreen)
            .frame(height: 50)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.2), lineWidth:1)
            }
    }
}

// Extension to easily reuse the modifier
extension View {
    func customTextFieldStyle() -> some View {
        self.modifier(CustomTextFieldStyle())
    }
}


#Preview {
    SignIn()
}

struct AuthButton: View {
    let title: String
    let image: String
    
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Spacer()
                Image(systemName: image)
                TextView(size: 16, title: title)
                Spacer()
            }
            .fontWeight(.semibold)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.customGreen)
                }
        })

    }
}


struct MainBtnView: View {
    let title: String
    
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            if let action = action {
                           action() // Call the passed function
                       }         }, label: {
            TextView(size: 16, title: title)
                .fontWeight(.bold)
                .foregroundStyle(Color.customGreen)
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.customPink)
                }
        })
    }
}
