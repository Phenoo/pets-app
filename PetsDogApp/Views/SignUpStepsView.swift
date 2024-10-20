//
//  SignUpStepsView.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 19/09/2024.
//

import SwiftUI

struct Breed: Hashable {
    let image: String
    let name: String
    let color: Color
}

enum SignSteps: Int, CaseIterable {
    case one
    case two
    case three
    case four
    case five
    case six
    
    var title: String {
        switch self {
        case .one:
            "Next to Species"
        case .two:
            "Next to Breed"
        case .three:
            "Next to Gender"
        case .four:
            "Next to Neuter"
        case .five:
            "Next to Age"
        case .six:
            "Done"
        }
    }
    var desc: String {
        switch self {
        case .one:
            "What's the \n name of your pet."
        case .two:
            "Tell us what's \n your pet's species."
        case .three:
            "What about \n Your pet's breed?"
        case .four:
            "What about \n Your pet's gender?"
        case .five:
            "Is Pet neuter?"
        case .six:
            "How old is Tommy?"
        }
        
    }
    
    func next() -> SignSteps? {
        let allCases = SignSteps.allCases
        guard let currentIndex = allCases.firstIndex(of: self) else { return nil }
        let nextIndex = allCases.index(after: currentIndex)
        return nextIndex < allCases.endIndex ? allCases[nextIndex] : nil
    }
}
struct SignUpStepsView: View {
    
    @State private var step: SignSteps = .one
    @State private var text: String = ""
    
    @State private var setup: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customGreen
                VStack(alignment: .leading, spacing: 40) {
                    VStack(alignment: .leading) {
                        BodyTextView(size: 35, title: step.desc)
                    }
                    .fontWeight(.semibold)
                    .padding()
                    
                    VStack(spacing: 30) {
                        switch step {
                        case .one:
                            NameSpecies(step: $step)
                        case .two:
                            SpeciesBreed()
                        case .three:
                            BreedView()
                        case .four:
                            GenderView()
                        case .five:
                            NeuterView()
                        case .six:
                            AgeView()
                        }
                        
                        if step != .one {
                            Button(action: {
                                withAnimation(.snappy(duration: 1)){
                                    if let nextStep = step.next() {
                                        step = nextStep
                                    } else {
                                        setup = true
                                    }
                                }
                                
                            }, label: {
                                TextView(size: 16, title: step.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.customGreen)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.customPink)
                                    }
                            })
                        }
                        
                    }
                    .padding()
                    .padding(.vertical, 60)
                    .frame(maxWidth: .infinity, maxHeight: step == .one ? 500 : 550, alignment: .center)
                    .background{
                        Rectangle()
                            .fill(Color.white)
                            .clipShape(
                                .rect(topLeadingRadius: 20, topTrailingRadius: 20)
                            )
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .foregroundStyle(.white)
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $setup) {
                SettingUpView()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    BodyTextView(size: 32, title: "Petazy")
                        .foregroundStyle(Color.customPink)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .padding(8)
                            .font(.subheadline)
                            .foregroundStyle(Color.customYellow)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack{
                        Text("\(step.rawValue + 1)")
                            .font(.title2)
                            .foregroundStyle(Color.customYellow)
                            .fontWeight(.semibold)
                        +
                        Text("/6")
                    }
                    .font(.custom("Isidora", size: 18))
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                }
            }
            
        }
    }
}

struct NameSpecies: View {
    @State private var text: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    @Binding var step : SignSteps
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    TextField("Type your pet name", text: $text)
                        .padding()
                        .font(.custom("Isidora", size: 25))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.customGreen)
                        .focused($isTextFieldFocused)   // Set focus state for the TextField
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isTextFieldFocused = true
                            }
                        }
                    
                    BodyTextView(size: 14, title: "Eg: Ghost, Maxa")
                        .foregroundStyle(Color.customGreen)
                        .fontWeight(.semibold)
                }
                Button(action: {
                    withAnimation {
                        step = .two
                    }
                    
                }, label: {
                    TextView(size: 16, title: step.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.customGreen)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.customPink)
                        }
                })
            }
        }
    }
}


struct SpeciesBreed: View {
    
    @State private var selectedBreed: Breed?
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    let data: [Breed] = [
        Breed(image: "cat", name: "cat", color: Color.customBlue),
        Breed(image: "dog", name: "dog", color: Color.customYellow),
        Breed(image: "bird", name: "bird", color: .green),
        Breed(image: "rabbit", name: "rabbit", color: Color.customPink)
    ]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 50) {
            ForEach(data, id: \.self) { item in
                VStack {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 100, height: 100)
                        .background {
                            Circle()
                                .fill(item.color.opacity(0.4))
                                .stroke(item.color, lineWidth: selectedBreed == item ? 4 : 0)
                        }
                        .onTapGesture {
                            withAnimation {
                                selectedBreed = item
                            }
                        }
                    BodyTextView(size: 20, title: item.name.capitalized)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.customGreen)
                }
            }
        }
    }
}

struct BreedView: View {
    @State private var text: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                TextField("e.g, Bernaldine", text: $text)
                    .padding()
                    .font(.custom("Isidora", size: 25))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.customGreen)
                    .focused($isTextFieldFocused)   // Set focus state for the TextField
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.isTextFieldFocused = true
                        }
                    }
                
                HStack(spacing: 40){
                    TextView(size: 16, title: "Mixed")
                        .foregroundStyle(Color.customGreen)
                        .fontWeight(.bold)
                        .underline()
                    TextView(size: 16, title: "I don't know")
                        .foregroundStyle(Color.customGreen)
                        .fontWeight(.bold)
                        .underline()
                }
            }
        }
    }
}

struct GenderView: View {
    
    @State private var gender : String = ""
    @State private var animateRipple = false  // State to animate the ripple effect
    
    var body: some View {
        ScrollView {
            VStack(spacing: 60){
                HStack(spacing: 50) {
                    HStack {
                        Text("♀︎")
                    }
                    .font(.custom("", size: 40))
                    .foregroundStyle(gender == "male" ? .white : Color.customGreen)                        .frame(width: 120, height: 120)
                    .background {
                        RadioChooseView(gender: $gender, maingender: "male")
                    }
                    .onTapGesture {
                        withAnimation {
                            gender = "male"
                        }
                    }
                    
                    HStack {
                        Text("♂︎")
                    }
                    .frame(width: 120, height: 120)
                    .font(.custom("", size: 40))
                    .foregroundStyle(gender == "female" ? .white : Color.customGreen)
                    .background {
                        RadioChooseView(gender: $gender, maingender: "female")
                    }
                    .onTapGesture {
                        withAnimation {
                            gender = "female"
                        }
                    }
                }
                
                TextView(size: 18, title: "I don't know")
                    .foregroundStyle(Color.customGreen)
                    .fontWeight(.bold)
                    .underline()
            }
        }
    }
}

struct NeuterView: View {
    
    @State private var gender : String = ""
    @State private var animateRipple = false  // State to animate the ripple effect
    
    var body: some View {
        ScrollView {
            VStack(spacing: 60){
                HStack(spacing: 50) {
                    HStack {
                        BodyTextView(size: 20, title: "Yes")
                            .fontWeight(.bold)
                        
                    }
                    .foregroundStyle(gender == "Yes" ? .white : Color.customGreen)                        .frame(width: 120, height: 120)
                    .background {
                        RadioChooseView(gender: $gender, maingender: "Yes")
                    }
                    .onTapGesture {
                        withAnimation {
                            gender = "Yes"
                        }
                    }
                    
                    HStack {
                        BodyTextView(size: 20, title: "No")
                            .fontWeight(.bold)
                    }
                    .frame(width: 120, height: 120)
                    .foregroundStyle(gender == "No" ? .white : Color.customGreen)
                    .background {
                        RadioChooseView(gender: $gender, maingender: "No")
                    }
                    .onTapGesture {
                        withAnimation {
                            gender = "No"
                        }
                    }
                }
                
                TextView(size: 18, title: "I don't know")
                    .foregroundStyle(Color.customGreen)
                    .fontWeight(.bold)
                    .underline()
            }
        }
    }
}

struct RadioChooseView : View {
    @State private var animateRipple = false  // State to animate the ripple effect
    
    @Binding var gender: String
    
    let maingender: String
    
    var body: some View {
        Circle()
            .fill(gender == maingender ? Color.customPink : .clear)
            .overlay(
                Circle()
                    .stroke(gender != maingender ? .gray : .clear, lineWidth: 1)
                    .scaleEffect(animateRipple ? 1.8 : 1)  // Expands outward for ripple effect
                    .opacity(animateRipple ? 0 : 1)        // Fades out during the animation
            )
            .animation(.easeInOut(duration: 0.6), value: animateRipple)  // Animation for ripple effect
            .onChange(of: gender) { newGender in
                if newGender == "female" {
                    animateRipple = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        animateRipple = false
                    }
                }
            }
    }
}


struct AgeView: View {


    var body: some View {
        VStack(spacing: 50){
            VStack {
                TextView(size: 24, title: "Years")
                    .fontWeight(.bold)
                
               
                ScrollSelecterView()
            }
            VStack {
                TextView(size: 24, title: "Months")
                    .fontWeight(.bold)
                ScrollSelecterView()
            }
        }
        .foregroundStyle(Color.customGreen)
    }
}

#Preview {
    SignUpStepsView()
}

struct ScrollSelecterView: View {
    @State private var selectedYear: Int = 1

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 40) {
                    ForEach(0..<10, id: \.self) { item in
                        TextView(size: selectedYear == item ? 34 : 20, title: "\(item)")
                            .padding()
                            .frame(width: 70, height: 70)
                            .background {
                                Circle()
                                    .stroke(lineWidth: selectedYear == item ? 1 : 0)
                            }
                            .id(item) // Assign an ID for scrolling
                            .onTapGesture {
                                selectedYear = item
                                withAnimation {
                                    scrollProxy.scrollTo(item, anchor: .center) // Scroll to selected year
                                }
                            }
                    }
                }
                .onAppear {
                    selectedYear = 1
                    withAnimation {
                        scrollProxy.scrollTo(1, anchor: .center) // Scroll to selected year
                    }
                }
            }.frame(height: 120)
        }
    }
}
