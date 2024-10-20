//
//  PetActivityScreenView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 21/09/2024.
//

import SwiftUI

struct DateGenerator {
    static func generateDates() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        
        // Get "yesterday"
        guard let yesterday = calendar.date(byAdding: .day, value: -2, to: today) else {
            return []
        }
        
        // Generate dates from yesterday to the next 30 days
        var dates = [Date]()
        for offset in 0..<31 { // 31 days total, including yesterday
            if let date = calendar.date(byAdding: .day, value: offset, to: yesterday) {
                dates.append(date)
            }
        }
        return dates
    }
}

struct PetActivityScreenView: View {
    @State private var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    
    let dates: [Date] = DateGenerator.generateDates()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customGreen
                ScrollView {
                VStack {
                    HStack{
                        TextView(size: 28, title: "Today")
                            .fontWeight(.bold)
                        Spacer()
                        Text(Date.now.addingTimeInterval(600), style: .date)
                            .font(.subheadline)
                            .opacity(0.5)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .padding()
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing: 10) {
                            ForEach(dates, id: \.self) { date in
                                DayView(date: date, selectedDate: $selectedDate)
                            }
                        }
                        .padding(.horizontal)
                        
                    }.frame(height: 130)
                    VStack(spacing: 30){
                        HStack {
                            TextView(size: 24, title: "To Take")
                                .fontWeight(.bold)
                                .foregroundStyle(.accent)
                            Spacer()
                            
                            NavigationLink(destination: AddDailyReminderView()
                                
                                           , label: {
                                Label("Add", systemImage: "plus")
                                    .font(.subheadline)
                                    .foregroundStyle(.green)
                                    .fontWeight(.bold)
                            })
                        
                        }
                        .padding()
                        HStack(alignment: .top, spacing: 20){
                            TextView(size: 20, title: "12 AM")
                            ActivityCardView(color: Color.customBlue)
                        }
                        HStack(alignment: .top, spacing: 20){
                            TextView(size: 20, title: "12 PM")
                            ActivityCardView(color: Color.customYellow)
                        }
                        HStack(alignment: .top, spacing: 20){
                            TextView(size: 20, title: "2 AM")
                            ActivityCardView(color: Color.customPink)
                        }
                       
                        HStack(alignment: .top, spacing: 20){
                            TextView(size: 20, title: "2 AM")
                            ActivityCardView(color: Color.customGreen)
                        }
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        Rectangle()
                            .fill(Color.customGray)
                            .clipShape(
                                .rect(topLeadingRadius: 20, topTrailingRadius: 20)
                            )
                    }
                }
            }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.customGreen, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TextView(size: 30, title: "Petazy")
                        .foregroundStyle(Color.customPink)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

struct DayView: View {
    let date: Date
    
    @Binding var selectedDate: Date
    
    var dayString: String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        return dayFormatter.string(from: date)
    }
    
    var monthString: String {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "EEE"
        return monthFormatter.string(from: date)
    }
    
    var isSelected: Bool {
        let calendar = Calendar.current
        return calendar.isDate(selectedDate, inSameDayAs: date)       }
    
    
    
    var body: some View {
        
        
        VStack(spacing: 8) {
            TextView(size: 16, title: monthString)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? Color.customGreen : Color.white.opacity(0.3))
            
            
            TextView(size: 18, title: dayString) // Day number
                .fontWeight(.bold)
                .foregroundColor(isSelected ? Color.customGreen : Color.white)
            
            
        }
        .padding(.vertical, 12)
        .frame(width: 60)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(isSelected ? Color.customPink : Color.clear)
                .stroke(Color.customPink.opacity(0.4))
        }
        .onTapGesture{
            selectedDate = date
        }
    }
}

#Preview {
    PetActivityScreenView()
}
