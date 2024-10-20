//
//  HomeScreenView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 20/09/2024.
//

import SwiftUI

struct Services: Identifiable {
    let id: Int
    let title: String
    let image: String
    let desc: String
}

struct HomeScreenView: View {
    @State private var height: CGFloat = 500

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customGreen
                ScrollView{
                    VStack(spacing: 40){
                        VStack(spacing: 25){
                            VStack {
                                BodyTextView(size: 35, title: "Smart pet care")
                                    .fontWeight(.semibold)
                                
                                TextView(size: 16, title: "Find perfect veterain for your pet")
                                    .opacity(0.5)
                                    .fontWeight(.medium)
                            }
                            
                            Button(action: {
                                
                            }, label: {
                                TextView(size: 14, title: "Vet Appointment")
                                    .foregroundStyle(Color.customGreen)
                                    .fontWeight(.semibold)
                                    .padding()
                                    .padding(.horizontal, 25)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.customPink)
                                    }
                            })
                        }
                        .padding(.top, 30)
                        .foregroundStyle(.white)
                        VStack(spacing: 40){
                            QuickServicesView()
                            
                            QuickPharmacyView()
                            
                            PetShopView()
                            
                            QuickPetActivityView()
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background {
                            Rectangle()
                                .fill(Color.customGray)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 30,
                                        topTrailingRadius: 30
                                    )
                                )}
                        .offset(y: height)

                    }
                }
               

                
            }
            
            .onAppear {
                withAnimation(.bouncy(duration: 1)) {
                    height = 0
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    HStack {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(Color.customPink)
                    }
                }
                ToolbarItem(placement: .principal) {
                    BodyTextView(size: 32, title: "Petazy")
                        .foregroundStyle(Color.customPink)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarTrailing){
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.subheadline)
                            .padding(8)
                            .foregroundStyle(Color.customYellow)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray.opacity(0.5))
                            }
                    }
                }
                
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.customGreen, for: .navigationBar)
        }
    }
}



struct QuickServicesView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    
    let items : [Services] = [
        Services(id: 1, title: "Health A-Z", image: "person.fill.badge.plus", desc: "Pet guide center"),
        Services(id: 2, title: "Vaccination", image: "syringe", desc: "Quick vaccination"),
        Services(id: 3, title: "Pet Hospital", image: "homekit", desc: "Nearby Hospitals"),
        Services(id: 4, title: "insurance", image: "heart.text.square", desc: "Secured Pet Life")
    ]
    
    var body: some View {
        VStack {
            SectionHeader(title: "Quick Services")

            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items) { service in
                    HStack (spacing: 16){
                        Image(systemName: service.image, variableValue: 0.5)
                            .font(.title)
                        VStack(alignment: .leading, spacing: 6){
                            TextView(size: 17, title: service.title.capitalized )
                                .fontWeight(.semibold)
                            TextView(size: 13, title: service.desc)
                        }
                        .foregroundStyle(.accent)
                        
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                    }
                }
            }
        }
    }
}


struct QuickPharmacyView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            SectionHeader(title: "Pet Pharmacy")
            LazyVGrid(columns: columns) {
                    ShopCardView(image: MyImage.samples[1])
                    ShopCardView(image: MyImage.samples[2])
                    ShopCardView(image: MyImage.samples[3])
                ShopCardView(image: MyImage.samples[4])
            }
        }
    }
}


struct PetShopView: View {
    var body: some View {
        VStack {
            SectionHeader(title: "Pet Shop")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    PetShopItemHomeView(title: "Pet Food", image: "carrot", color: Color.customPink.opacity(0.8))
                    PetShopItemHomeView(title: "Pet Toys", image: "soccerball", color: Color.customYellow.opacity(0.8))
                    PetShopItemHomeView(title: "Furniture", image: "chair", color: Color.customBlue.opacity(0.8))
                    PetShopItemHomeView(title: "Clothes", image: "hanger", color: Color.customBlue.opacity(0.8))
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}

struct QuickPetActivityView :View{
    @State private var show: Bool = false
    
    var body: some View {
        VStack{
            HStack {
                TextView(size: 22, title: "Pet Activity")
                    .foregroundStyle(.accent)
                    .fontWeight(.bold)
                Spacer()
                TextView(size: 16, title: "Add")
                    .foregroundStyle(Color.customYellow)
                    .fontWeight(.bold)
                    .onTapGesture {
                        show = true
                    }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30){
                    HStack(alignment: .top, spacing: 20){
                        TextView(size: 20, title: "2 AM")
                        ActivityCardView(color: Color.customPink)
                    }                }
            }
        }
        .fullScreenCover(isPresented: $show) {
            AddDailyReminderView()
        }
        
    }
}

struct ActivityCardView: View {

    let color: Color
    
    var body: some View {
        HStack(spacing: 20){
            Rectangle()
                .foregroundStyle(color)
                .frame(width: 8)
                .frame(maxHeight: .infinity)
                .clipShape(
                    .rect(
                        topLeadingRadius: 15,
                        bottomLeadingRadius: 15
                    )
                )
              
            
            VStack(alignment: .leading, spacing: 25) {

                VStack(alignment: .leading) {
                    TextView(size: 18, title: "NexGard Chewables, 10mg")
                        .fontWeight(.bold)
                    TextView(size: 14, title: "1 Tablet, per day")
                }
                
                HStack {
                    Label("10:00 - 01.00", systemImage: "clock")
                        .font(.caption)
                    Spacer()
                    Image(systemName: "bell")
                        .font(.title2)
                }
            }
            .padding(.trailing)
            
        }
        .foregroundStyle(.accent)
        .frame(width: 280, height: 120)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
        }
    }
}

struct PetShopItemHomeView : View {
    let title: String
    let image: String

    let color: Color

    
    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.headline)
                .foregroundStyle(.accent)
                .padding(8)
                .background {
                    Circle()
                        .fill(.white)
                }
            
            TextView(size: 18, title: title)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
        }

    }
}

struct ShopCardView: View {
    let image: MyImage
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack(alignment: .topLeading) {
                Image(image.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                
                TextView(size: 14, title: "15% OFF")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.customGreen)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background {
                        Rectangle()
                            .fill(Color.customPink)
                    }
            }
            HStack {
                TextView(size: 14, title: "Merrick Purfect Bistro Grain")
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal, 8)
            
            
            HStack {
                TextView(size: 16, title: "$12.16")
                Spacer()
                Image(systemName: "plus")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(8)
                    .foregroundStyle(Color.customGreen)
                    .background {
                        Circle()
                            .fill(Color.customPink)
                    }                    }
            .padding(.horizontal, 8)
            
            
        }
        .padding(.vertical)
        .foregroundStyle(Color.customGreen)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        }
    }
}
