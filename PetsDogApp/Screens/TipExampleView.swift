//
//  TipExampleView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 23/09/2024.
//


import SwiftUI
import TipKit


// Define your tip's content.
struct FavoriteLandmarkTip: Tip {
    var title: Text {
        Text("Save as a Favorite")
    }


    var message: Text? {
        Text("Your favorite landmarks always appear at the top of the list.")
    }


    var image: Image? {
        Image(systemName: "star")
    }
}



struct TipExampleView: View {
    var favoriteLandmarkTip = FavoriteLandmarkTip()

    var body: some View {
        VStack {
                        // Place the tip view near the feature you want to highlight.
                        TipView(favoriteLandmarkTip, arrowEdge: .bottom)


                        Image(systemName: "star")
                            .imageScale(.large)
                        Spacer()
                    }
                    .task {
                        // Configure and load your tips at app launch.
                        do {
                            try Tips.configure([
                                .displayFrequency(.immediate),
                                .datastoreLocation(.applicationDefault)
                            ])
                        }
                        catch {
                            // Handle TipKit errors
                            print("Error initializing TipKit \(error.localizedDescription)")
                        }
                    }
                }    }


#Preview {
    TipExampleView()
}
