//
//  SettingUpView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 19/09/2024.
//

import SwiftUI
import Lottie

struct SettingUpView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customGreen
                VStack(spacing: 20){
                    VStack {
                             LottieView(animationName: "master", loopMode: .loop)
                                 .frame(height: 250)
                                 .cornerRadius(20)
                         }
                    TextView(size: 24, title: "We're Setting Up")
                        .fontWeight(.bold)
                    
                    TextView(size: 16, title: "We are setting up your profile. Your \n information will be saved for future \n activities with petazy.")
                        .fontWeight(.bold)
                        .foregroundStyle(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
            }
            .foregroundStyle(.white)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingUpView()
}
