//
//  PopView.swift
//  SmartHome
//
//  Created by Eze Chidera Paschal on 17/09/2024.
//

import SwiftUI


struct Config {
    var backgroundColor: Color = .black.opacity(0.5)
    
}

extension View {
    @ViewBuilder
    func popView<Content: View>(
        config: Config = .init(),
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> (),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .modifier( PopViewHelper(config: config, isPresented: isPresented, onDismiss: onDismiss, viewContent: content))
    }
}

fileprivate struct PopViewHelper<ViewContent: View>: ViewModifier {
    var config: Config

    @Binding var isPresented: Bool

    var onDismiss: () -> ()
    
    @ViewBuilder var viewContent: ViewContent
    
    @State private var presentationFullScreen: Bool = false
    @State private var animateView: Bool = false
    
    func body(content: Content) -> some View {
        let screenHeight = screenSize.height
        let animateView = animateView
        
        content
            .fullScreenCover(isPresented: $isPresented, onDismiss: onDismiss) {
                ZStack{
                    Rectangle()
                    .fill(config.backgroundColor)
                    .ignoresSafeArea()
                    .opacity(animateView ? 1 : 0)
//                    .blur(radius: 40)
                viewContent
                    .visualEffect({ content, proxy in
                        content
                            .offset(y: offset(proxy, screenSize: screenHeight, animateView: animateView))
                    })
                    .presentationBackground(.clear)
                    .task {
                        guard !animateView else { return }
                        withAnimation(.bouncy(duration: 0.4, extraBounce: 0.05)) {
                            self.animateView = true
                        }
                    }
                    .ignoresSafeArea(.container, edges: .all)
            }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                if newValue {
                    toggleView(true)
                    
                } else {
                    Task {
                        withAnimation(.snappy(duration: 0.45, extraBounce: 0)) {
                            self.animateView = false
                        }
                        
                        try? await Task.sleep(for: .seconds(0.45))
                        
                        toggleView(false)
                    }
                }
            }
    }
    
    func toggleView(_ status: Bool) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        
        withTransaction(transaction) {
            presentationFullScreen = status
        }
    }
    
    nonisolated func offset(_ proxy: GeometryProxy, screenSize: CGFloat, animateView: Bool) -> CGFloat {
        let viewHeight = proxy.size.height
        return animateView ? 0 : (screenSize + viewHeight) / 2
    }
    
    var screenSize: CGSize {
        if let screenSize = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.size {
            return screenSize
        }
        
        return .zero
    }
    
}


struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
