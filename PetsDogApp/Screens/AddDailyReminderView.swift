//
//  AddDailyReminderView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 21/09/2024.
//

import SwiftUI

struct AddDailyReminderView: View {
    @State private var name: String = ""
    @State private var type: String = ""

    @State private var popupDone: Bool = false
    @State private var popupDate: Bool = false
    @State private var popupTime: Bool = false
    
   
    @State private var popupDateValue: Date = Date()
    @State private var popupTimeValue: Date = Date()
    @State private var height: CGFloat = 1000

    
    @Environment(\.dismiss) var dismiss
    
    
    func formattedDate(_ date: Date) -> String {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium // Customize the date style
          formatter.timeStyle = .none   // Customize the time style (optional)
          return formatter.string(from: date)
      }
    
    func formattedTime(_ date: Date) -> String {
          let formatter = DateFormatter()
          formatter.timeStyle = .medium // Customize the time style (e.g., .short, .medium, .long)
          formatter.dateStyle = .none   // Hide the date (optional)
          return formatter.string(from: date)
      }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customGreen
                ScrollView {
                VStack(spacing: 30){
                    VStack {
                        BodyTextView(size: 35, title: "Add daily reminder")
                            .fontWeight(.semibold)
                        
                        TextView(size: 16, title: "And set your schedule")
                            .opacity(0.5)
                            .fontWeight(.medium)
                    }
                    .padding(.top, 54)
                    
                    VStack(alignment: .leading, spacing: 20){
                        TextView(size: 16, title: "REMINDER TYPE")
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                        
                        HStack {
                            ReminderTypeView(image: "syringe", title: "Vaccine", color: Color.yellow, type: $type)
                            ReminderTypeView(image: "capsule.lefthalf.filled", title: "Medicine", color: Color.customPink, type: $type)
                            ReminderTypeView(image: "waterbottle.fill", title: "Liquid", color: Color.customBlue, type: $type)
                            
                        }
                        
                        TextView(size: 16, title: "REMINDER NAME")
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                        
                        TextField("Name", text: $name)
                            .foregroundStyle(.accent)

                        
                        Divider()
                        TextView(size: 16, title: "DURATION")
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                        
                        
                        HStack {
                            Text("\(formattedDate(popupDateValue))")
                                .foregroundStyle(.accent)

                            Spacer()
                            Button(action: {
                                popupDate = true
                            }, label: {
                                Label("Add", systemImage: "plus")
                                    .font(.subheadline)
                                    .foregroundStyle(.green)
                                    .fontWeight(.bold)
                            })
                        }
                        Divider()
                        
                        TextView(size: 16, title: "TIME")
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                        HStack {
                            Text("\(formattedTime(popupTimeValue))")
                                .foregroundStyle(.accent)

                            Spacer()
                            Button(action: {
                                popupTime = true
                            }, label: {
                                Label("Add", systemImage: "plus")
                                    .font(.subheadline)
                                    .foregroundStyle(.green)
                                    .fontWeight(.bold)
                            })
                        }
                        Divider()
                        TextView(size: 16, title: "AMOUNT")
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                        
                        HStack {
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "minus")
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background {
                                        Circle()
                                            .stroke(.gray, lineWidth: 2)
                                    }
                            })
                            TextView(size: 20, title: "2 Pills")
                                .foregroundStyle(.accent)
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "plus")
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background {
                                        Circle()
                                            .stroke(.gray, lineWidth: 2)
                                    }
                            })
                        }
                        .foregroundStyle(Color.customGreen)


                        
                        
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 30)
                    .padding(.bottom, 100)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                
                    .background {
                        Rectangle()
                            .fill(Color.customGray)
                            .clipShape(
                                .rect(topLeadingRadius: 20, topTrailingRadius: 20)
                            )
                    }
                }
                }.offset(y: height)
            }
            .overlay(alignment: .bottom){
                VStack {
                    MainBtnView(title: "Save", action: {
                        popupDone = true
                    })
                }
                .padding(30)
                .background {
                    Rectangle()
                        .fill(Color.customGray)
                }
            }
            .popView(isPresented: $popupDone, onDismiss: {}) {
                VStack(spacing: 20){
                    Image(systemName: "capsule.lefthalf.filled")
                        .font(.title)
                        .padding()
                        .frame(width: 70, height: 70)
                        .background {
                            Circle()
                                .fill(Color.customPink)
                                .background {
                                    Circle()
                                        .padding(-2)
                                }
                        }

                    
                    TextView(size: 26, title: "Pill added successfully")
                        .fontWeight(.bold)
                        .foregroundStyle(Color.customGreen)
                    
                    VStack {
                        TextView(size: 18, title: "Pill added successfully")
                        TextView(size: 18, title: "Thank you for using our app")
                    }
                    .padding(.bottom)
                        .foregroundStyle(.gray)
                }
                .padding()
                .frame(width: 350)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .padding(.top, 55)
                       
                }
            }
            .popView(isPresented: $popupDate, onDismiss: {}) {
                VStack {
                    DatePicker("", selection: $popupDateValue, displayedComponents: [.hourAndMinute])
                        .foregroundStyle(Color.customGreen)
                        .tint(.accent)
                        .datePickerStyle(.wheel)
                    
                    MainBtnView(title: "Done", action: {
                        popupDate = false
                    })
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                }
            }
            .popView(isPresented: $popupTime, onDismiss: {}) {
                VStack {
                    DatePicker("", selection: $popupTimeValue, displayedComponents: [.hourAndMinute])
                        .foregroundStyle(Color.customGreen)
                        .tint(.accent)
                        .datePickerStyle(.wheel)
                    
                    MainBtnView(title: "Done", action: {
                        popupTime = false
                    })
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                }
            
            }
            .onAppear {
                withAnimation(.spring) {
                    height = 0
                }
            }
            .foregroundStyle(Color.white)
            .ignoresSafeArea(edges: [.bottom])
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbarBackground(Color.customGreen, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TextView(size: 20, title: "Add Reminder")
                        .foregroundStyle(Color.customPink)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                    }, label: {
                        TextView(size: 18, title: "Save")
                            .foregroundStyle(.green)
                            .fontWeight(.semibold)
                    })
                }
                ToolbarItem(placement: .topBarLeading){
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
                    .onTapGesture {
                        dismiss()
                    }
                }
            }

        }
    }
}

struct ReminderTypeView: View {
    let image: String
    let title: String
    let color: Color
    
    @Binding var type: String
    
    
    var body: some View {
        VStack(spacing: 5){
            Image(systemName: image)
                .font(.title)
                .frame(height: 40)
                .foregroundStyle(color)
            TextView(size: 16, title: title)
                .foregroundStyle(Color.customGreen)
                .fontWeight(.bold)
        }
        .padding()
        .frame(width: 100)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(color, lineWidth: type == title ? 2 : 0)
        }
        .onTapGesture {
            withAnimation {
                type = title
            }
        }
    }
}

#Preview {
    AddDailyReminderView()
}
