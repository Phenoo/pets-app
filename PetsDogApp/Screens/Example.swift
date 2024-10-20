//
//  Example.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 21/09/2024.
//

import SwiftUI

struct Example: View {
    
    @State private var secOneDate = Date()
    @State private var secTwoDate = Date()
    @State private var isDatepickerOnePresented = false
    @State private var isDatepickerTwoPresented = false

    var body: some View {
        VStack {
            HStack{
                Button{
                    isDatepickerOnePresented = true
                } label: {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                        .foregroundColor(.indigo)
                        
                }
                .sheet(isPresented: $isDatepickerOnePresented){
                    DatePickView(selectDate: $secOneDate)
                }
                
                Text("SecOneDate: \(secOneDate.formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
            
            HStack{
                Button{
                    isDatepickerTwoPresented = true
                } label: {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                        .foregroundColor(.mint)
                    
                }
                .sheet(isPresented: $isDatepickerTwoPresented) {
                    DatePickView(selectDate: $secTwoDate)
                }
                Text("SecTwoDate: \(secTwoDate.formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
            
        }
    }
}



struct DatePickView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var selectDate: Date
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text("\(selectDate)")
                    .padding()
                
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "delete.backward.fill")
                        .foregroundColor(.indigo)
                }
                
            }.padding()
            
            
            DatePicker("", selection: $selectDate)
                .datePickerStyle(.graphical)
            
        }
    }
}


#Preview {
    Example()
}
