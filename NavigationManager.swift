//
//  NavigationManager.swift
//  Morphogram
//
//  Created by Osman Tufekci on 14.02.2025.
//
import SwiftUI
import Combine

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("chevron.left")
        }
    }
}

struct NavigationView<Content: View>: View, Hashable {
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var description: String{
        return title ?? "No title provided."
    }
    
    var title:String?
    var backButtonVisible: Bool = true
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: NavigationView<Content>, rhs: NavigationView<Content>) -> Bool {
        return lhs.title == rhs.title && lhs.title == rhs.title
    }
    
    let content: Content

    init(@ViewBuilder content: () -> Content, backButtonVisible: Bool = true) {
        self.content = content()
        self.backButtonVisible = backButtonVisible
    }

    var body: some View {
        if backButtonVisible {
            content
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton {
                            navigationManager.navigateBack()
                        }
                    }
                }
        } else {
            content
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

public final class NavigationManager: ObservableObject {
    
    @Published var path = NavigationPath()
    var backButtonVisible: Bool = true
    
    public static let shared = NavigationManager()
    
    init() { }
    
    public func navigate(_ page: some View, backButtonVisible: Bool = true) {
        path.append(NavigationView(
            content: {
                AnyView(page)
            }, backButtonVisible: backButtonVisible)
        )
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateRoot() {
        path = NavigationPath()
    }
}
