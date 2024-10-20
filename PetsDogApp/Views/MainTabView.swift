//
//  MainTabView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 19/09/2024.
//

import SwiftUI

struct MainTabView: View {
    
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.customGreen)
        UITabBar.appearance().barTintColor = UIColor(Color.gray)
        UITabBarItem.appearance().badgeColor = UIColor(Color.customPink)
        UITabBar.appearance().backgroundImage = UIImage()
    }
    @State private var selectedTab = 1
    
    var body: some View {
            TabView(selection: $selectedTab,
                    content:  {
                HomeScreenView().tabItem { HStack {
                    Image(systemName: "house")
                        .font(.headline)
                } }.tag(1)
                    .background(Color.red) // Apply the background here

                PharmacyScreenView().tabItem { HStack {
                    Image(systemName: "bag")
                        .font(.headline)
                } }.tag(2)
                    .badge(3)
                
                Text("s").tabItem {
                    HStack {
                        Image(systemName: "pawprint")
                    }
                    .padding(.top)
                }.tag(3)

                
                Text("s").tabItem {
                    HStack {
                        Image(systemName: "chart.pie")
                    }
                    .padding(.top)
                }.tag(3)

                
               Text("s").tabItem {
                   HStack {
                       Image(systemName: "person.circle")
                   }
                   .padding(.top)
               }.tag(5)
                
                
            }).tint(Color.customPink)
    }
}


#Preview {
    MainTabView()
}
