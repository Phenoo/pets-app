//
//  CustomTextFieldWithKeyboard.swift
//  PetsDogApp
//
//  Created by Eze Chidera Paschal on 24/09/2024.
//

import SwiftUI

struct CustomTextFieldWithKeyboard<TextField: View, Keyboard: View> : UIViewControllerRepresentable {
    @ViewBuilder var textField: TextField
    @ViewBuilder var keyboard: Keyboard
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIHostingController(rootView: textField)
        controller.view.backgroundColor = .clear
        
        
        DispatchQueue.main.async {
            if let textField = controller.view.allSubviews.first(where: { $0 is
                UITextField }) as? UITextField {
                let inputController = UIHostingController(rootView: keyboard)
                inputController.view.backgroundColor = .clear
                inputController.view.frame = .init(origin: .zero, size: inputController.view.intrinsicContentSize)
                textField.inputView = inputController.view
                textField.reloadInputViews()
            }
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: UIViewControllerType, context: Context) -> CGSize? {
        return uiViewController.view.intrinsicContentSize
    }
}


fileprivate extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.flatMap({ [$0] + $0.allSubviews })
    }
}


struct CustomKeyboardView: View {
    @Binding var text: String
    @FocusState.Binding var isActive: Bool
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 15) {
            ForEach(1...9, id: \.self) { index in
                ButtonView("\(index)")
            }
            
            ButtonView("delete.backward.fill", isImage: true)
            ButtonView("0")
            ButtonView("checkmark.circle.fill", isImage: true)
        }
        .padding(15)
        .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)))
    }
    
    @ViewBuilder
    func ButtonView(_ value: String, isImage: Bool = false) -> some View {
        Button {
            if isImage {
                if value == "delete.backward.fill" && !text.isEmpty {
                    text.removeLast()
                }
                
                if value == "checkmark.circle.fill" {
                    isActive = false
                }
            } else {
                text += value
            }
            
        } label: {
            Group {
                if isImage {
                    Image(systemName: value)
                } else {
                    Text(value)
                }
            }
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: 50, height: 50)
                .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 3, x: 0, y: 0)), in: .rect(cornerRadius: 10))
                .foregroundStyle(.accent)
        }
    }
}


struct TestingKeyboard: View {
    @State private var text: String = ""
    @FocusState private var isActive: Bool
    var body: some View {
        NavigationStack {
            CustomTextFieldWithKeyboard {
                TextField("App Pin Code", text: $text)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .frame(width: 250)
                    .background(.fill, in: .rect(cornerRadius: 15))
                    .focused($isActive)
            } keyboard: {
                CustomKeyboardView(text: $text, isActive: $isActive)
            }
            .navigationTitle("Keyboard")
        }
    }
}

#Preview {
    TestingKeyboard()
}
