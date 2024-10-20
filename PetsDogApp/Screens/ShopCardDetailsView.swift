//
//  ShopCardDetailsView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 21/09/2024.
//

import SwiftUI

struct ShopCardDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let image: MyImage
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customGreen
                ScrollView {
                    VStack(spacing: 40){
                        VStack {
                            Image(image.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                            
                            HStack(spacing: 10){
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "minus")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(Color.customGreen)
                                        .background {
                                            Circle()
                                                .fill(Color.customPink.opacity(0.2))
                                        }
                                })
                                
                                TextView(size: 18, title: "2")
                                    .fontWeight(.bold)
                                
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(Color.customGreen)
                                        .background {
                                            Circle()
                                                .fill(Color.customPink)
                                        }
                                })
                            }
                            .padding(4)
                            .background {
                                Capsule()
                                    .fill(.white)
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .trailing){
                            VStack {
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundStyle(.white.opacity(0.5))
                                
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundStyle(.white)
                                
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundStyle(.white)
                                
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundStyle(.white)
                            }
                            .padding()
                        }
                        
                        VStack(spacing: 30){
                            HStack {
                                TextView(size: 22, title: "Merick Purfect Bistro \n Grain")
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "heart.circle")
                                    .font(.title)
                                    .foregroundStyle(.gray)
                            }
                            
                            VStack(spacing: 20){
                                HStack {
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse")
                                        TextView(size: 16, title: "Near by Pharmacy")
                                    }
                                    .fontWeight(.medium)
                                    Spacer()
                                    HStack(spacing: 0){
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow.opacity(0.5))
                                        TextView(size: 16, title: "4.6 (1,248 Reviews)")
                                    }
                                    .fontWeight(.medium)
                                }
                                
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 10){
                                            TextView(size: 18, title: "Tamanana Pharmacy Ltd")
                                                .fontWeight(.bold)
                                            
                                            HStack {
                                                TextView(size: 14, title: "Arrives")
                                                TextView(size: 14, title: "15min")
                                                    .fontWeight(.semibold)
                                            }
                                        }
                                        Spacer()
                                        
                                        HStack {
                                            VStack(alignment: .trailing, spacing: 10){
                                                TextView(size: 16, title: "$10.21")
                                                TextView(size: 12, title: "Free Delivery")
                                                    .foregroundStyle(.green)
                                                    .fontWeight(.semibold)
                                            }
                                            
                                        }
                                    }
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                            .shadow(radius: 1)
                                    }
                                    
                                    HStack {
                                        VStack(alignment: .leading, spacing: 10){
                                            TextView(size: 18, title: "Tamanana Pharmacy Ltd")
                                                .fontWeight(.bold)
                                            
                                            HStack {
                                                TextView(size: 14, title: "Arrives")
                                                TextView(size: 14, title: "15min")
                                                    .fontWeight(.semibold)
                                            }
                                        }
                                        Spacer()
                                        
                                        HStack {
                                            VStack(alignment: .trailing, spacing: 10){
                                                TextView(size: 16, title: "$10.21")
                                                TextView(size: 12, title: "Free Delivery")
                                                    .foregroundStyle(.green)
                                                    .fontWeight(.semibold)
                                            }
                                            
                                        }
                                    }
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                            .shadow(radius: 1)
                                    }
                                    
                                    HStack {
                                        VStack(alignment: .leading, spacing: 10){
                                            TextView(size: 18, title: "Tamanana Pharmacy Ltd")
                                                .fontWeight(.bold)
                                            
                                            HStack {
                                                TextView(size: 14, title: "Arrives")
                                                TextView(size: 14, title: "15min")
                                                    .fontWeight(.semibold)
                                            }
                                        }
                                        Spacer()
                                        
                                        HStack {
                                            VStack(alignment: .trailing, spacing: 10){
                                                TextView(size: 16, title: "$10.21")
                                                TextView(size: 12, title: "Free Delivery")
                                                    .foregroundStyle(.green)
                                                    .fontWeight(.semibold)
                                            }
                                            
                                        }
                                    }
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                            .shadow(radius: 1)
                                    }
                                    
                                }
                                
                                
                                
                            }
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background {
                            Rectangle()
                                .fill(.white)
                                .clipShape(
                                    .rect(topLeadingRadius: 30, topTrailingRadius: 30)
                                )
                        }
                        
                    }
                }
            }
            .overlay(alignment: .bottom){
                VStack {
                    MainBtnView(title: "Add to Cart")
                }
                .foregroundStyle(Color.white)
                .padding(20)
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .background {
                    Rectangle()
                        .fill(Color.customGreen)
                        .clipShape(
                            .rect(topLeadingRadius: 30, topTrailingRadius: 30)
                        )
                }
            }
            .ignoresSafeArea(edges: [.bottom])
            .navigationBarBackButtonHidden()
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarBackground(Color.customGreen, for: .navigationBar)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "bag")
                        .font(.headline)
                        .foregroundStyle(Color.gray.opacity(0.9))
                        .padding(10)
                }
                
                ToolbarItem(placement: .principal) {
                    TextView(size: 20, title: "Product Details")
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
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    ShopCardDetailsView(image: MyImage.samples[0])
}
