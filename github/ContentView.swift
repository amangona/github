//
//  ContentView.swift
//  github
//
//  Created by abe on 4/13/20.
//  Copyright © 2020 abe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $viewModel.searchText)
                    .padding()
                List {
                    ForEach(viewModel.users) { user in
                        NavigationLink(destination: ProfileView(viewModel:  ProfileViewModel(user: user))) {
                            UserView(viewModel: UserViewModel(user: user))
                        }
                    }
                }
                .resignKeyboardOnDragGesture()
            }
            .navigationBarTitle(Text("Github Searcher"))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
