//
//  TextView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 19/09/2024.
//

import SwiftUI

struct TextView: View {
    let size: CGFloat
    let title: String
    
    var body: some View {
        Text(title)
            .font(.custom("Apercu Pro", size: size))
    }
}

struct SectionHeader: View {
    let title: String
    var body: some View {
        HStack {
            TextView(size: 22, title: title)
                .foregroundStyle(.accent)
                .fontWeight(.bold)
            Spacer()
            TextView(size: 16, title: "See all")
                .foregroundStyle(Color.customPink)
                .fontWeight(.bold)
        }

    }
}

struct BodyTextView: View {
    let size: CGFloat
    let title: String
    
    var body: some View {
        Text(title)
            .font(.custom("Isidora", size: size))
    }
}




#Preview {
    TextView(size: 30, title: "Hello")
}
