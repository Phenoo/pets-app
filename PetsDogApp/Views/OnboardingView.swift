//
//  OnboardingView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 19/09/2024.
//

import SwiftUI
import Lottie


enum Steps : Int, CaseIterable {
    case one
    case two
    case three
    
    
    func next() -> Steps? {
        let allCases = Steps.allCases
        guard let currentIndex = allCases.firstIndex(of: self) else { return nil }
        let nextIndex = allCases.index(after: currentIndex)
        return nextIndex < allCases.endIndex ? allCases[nextIndex] : nil
    }
}

struct OnboardingView: View {
    
    @State private var step: Steps = .one
    
    @State private var animate: Bool = false
    @State private var animateTwo: Bool = false
    
    @State private var open: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customGreen
                VStack(alignment: .leading, spacing: 30){

                    HStack(alignment: .center){
                        TextView(size: 35, title: "Petazy")
                            .foregroundStyle(Color.customPink)
                        Spacer()
                    Button(action: {
                        
                    }, label: {
                        TextView(size: 20, title: "Skip")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.customYellow)
                    })
                }
                    switch step {
                    case .one:
                        VStack {
                                HumanGradeView()
                                .opacity(animate ? 1 : 0)
                            
                        }.onAppear {
                            withAnimation(.interactiveSpring(duration: 1)){
                                animate = true
                            }
                        }
                    case .two:
                        VStack {
                            if animateTwo {
                            AffordableView()
                        }
                        }
                        .onAppear {
                            withAnimation(.spring(duration: 0.5, bounce: 0.5)){
                                animateTwo = true
                            }
                        }
                    case .three:
                        ShoppingView()
                    }
                    
                    
                    
                    HStack {
                        HStack(spacing: 16){
                            ForEach(Steps.allCases, id: \.self) { item in
                                Circle()
                                    .frame(width: step == item ? 10 : 8, height: step == item ? 10 : 6)
                                    .foregroundStyle(step == item ? Color.customYellow : Color.white.opacity(0.5))
                            }
                        }
                        
                        Spacer()
                        Button(action: {
                            withAnimation(.bouncy(duration: 1)){
                            if let nextStep = step.next() {
                                step = nextStep
                            } else {
                                open = true
                            }
                            }
                        }, label: {
                            BodyTextView(size: 14, title: step == .three ? "Get Started" : "Next")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.customGreen)
                                .padding(10)
                                .frame(width: 100, height: 100)
                                .background {
                                    Circle()
                                        .fill(Color.customPink)
                                }
                        })
                        
                    }
                    
                }
                .padding()
            }
            .fullScreenCover(isPresented: $open) {
                SignIn()
            }
            .foregroundStyle(.white)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    OnboardingView()
}

struct HumanGradeView: View {
    @State private var xaxis: CGFloat = 1000
    @State private var xaxisSec: CGFloat = 1000

    
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                BodyTextView(size: 35, title: "Petazy offer ")
                    .offset(x: xaxis)
                
                BodyTextView(size: 35, title: "Human Grade Care ")
                    .offset(x: xaxisSec)

                BodyTextView(size: 35, title: "Your Pets Deserve")
                    .offset(x: xaxis)

            }
            .fontWeight(.semibold)
            VStack {
                     LottieView(animationName: "mother", loopMode: .loop)
                         .frame(height: 350)
                         .cornerRadius(20)
                 }
            .transition(.opacity)

        }
        .onAppear {
            withAnimation(.bouncy(duration: 1.5)){
                xaxis = 0
            }
            withAnimation(.bouncy(duration: 2.0)){
                xaxisSec = 0
            }
        }
    }
}

struct AffordableView: View {
    @State private var xaxis: CGFloat = 1000
    @State private var xaxisSec: CGFloat = 1000
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                BodyTextView(size: 35, title: "Making Pet")
                    .offset(x: xaxis)

                BodyTextView(size: 35, title: "Care Accessible ")
                    .offset(x: xaxisSec)

                BodyTextView(size: 35, title: "and Affordable")
                    .offset(x: xaxis)

            }
            .fontWeight(.semibold)
            VStack {
                     LottieView(animationName: "affordable", loopMode: .loop)
                         .frame(height: 350)
                         .cornerRadius(20)
                 }
            .transition(.opacity)


        }
        .onAppear {
            withAnimation(.bouncy(duration: 1.5)){
                xaxis = 0
            }
            withAnimation(.bouncy(duration: 2.0)){
                xaxisSec = 0
            }
        }

    }
}

struct ShoppingView: View {
    @State private var xaxis: CGFloat = 1000
    @State private var xaxisSec: CGFloat = 1000
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                BodyTextView(size: 35, title: "Petazy offer you")
                    .offset(x: xaxis)

                BodyTextView(size: 35, title: "Ultimate Shopping ")
                    .offset(x: xaxisSec)

                BodyTextView(size: 35, title: "Experience")
                    .offset(x: xaxis)

            }
            .fontWeight(.semibold)
            VStack {
                     LottieView(animationName: "shopping", loopMode: .loop)
                         .frame(height: 350)
                         .cornerRadius(20)
                 }
            .transition(.opacity)


        }
        .onAppear {
            withAnimation(.bouncy(duration: 1.5)){
                xaxis = 0
            }
            withAnimation(.bouncy(duration: 2.0)){
                xaxisSec = 0
            }
        }

    }
}
