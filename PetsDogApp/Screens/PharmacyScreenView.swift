//
//  PharmacyScreenView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 21/09/2024.
//

import SwiftUI

struct PharmacyScreenView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Namespace var hero
 
    let images = ["shop1", "shop2", "shop3", "shop4"]
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.customGreen
                ScrollView {
                    VStack(spacing: 30){
                        VStack {
                            BodyTextView(size: 28, title: "All food items is here, \n for your pet")
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            TextView(size: 14, title: "Search through more than 1000+ food items")
                                .foregroundStyle(.gray)
                                .fontWeight(.medium)
                        }
                        .padding(.top)
                        
                        VStack {
                            SectionHeader(title: "Food Supplements")
                            PhotoGridView()
                        }
                  
                        VStack {
                            SectionHeader(title: "Top Brands")
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 20){
                                    Image("nutella")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 60)
                                        .padding()
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.gray.opacity(0.5))
                                        }
                                    Image("barbie")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 60)
                                        .padding()
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.gray.opacity(0.5))
                                        }
                                    Image("calvin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 60)
                                        .padding()
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.gray.opacity(0.5))
                                        }
                                }
                            }
                        }
                            VStack {
                                SectionHeader(title: "Weekly Top Sell")
                                
                                LazyVGrid(columns: columns) {
                                    ShopCardView(image: MyImage.samples[3])
                                    ShopCardView(image: MyImage.samples[2])
                                }
                            }

                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background {
                        Rectangle()
                            .fill(Color.white)
                            .clipShape(
                                .rect(topLeadingRadius: 30, topTrailingRadius: 30)
                            )
                    }
                }
            }
            .ignoresSafeArea(edges: [.bottom])
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarBackground(Color.customGreen, for: .navigationBar)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "bag")
                        .font(.subheadline)
                        .foregroundStyle(Color.customYellow.opacity(0.8))
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray.opacity(0.5))
                        }
                }
                
                ToolbarItem(placement: .principal) {
                    TextView(size: 20, title: "Pet Pharmacy")
                        .foregroundStyle(Color.customPink)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    PharmacyScreenView()
}
