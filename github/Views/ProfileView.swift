//
//  ProfileView.swift
//  github
//
//  Created by abe on 4/13/20.
//  Copyright © 2020 abe. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    var viewModel : ProfileViewModel
    @State var showingWebView = false
    @State var selectedRepo: Repo?
    
    var body: some View {
            VStack {
                HStack {
                    WebImage(url: URL(string: viewModel.profile?.avatarURL ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                    Spacer()
                    VStack {
                        Text(viewModel.profile?.name ?? "")
                        .font(.title)
                        .padding()
                    }
                }
                RepoSearchView(viewModel: viewModel) { repo in
                    self.selectedRepo = repo
                    self.showingWebView.toggle()
                }
                Spacer()
            }.sheet(isPresented: $showingWebView) {
                WebView(request: URLRequest(url: URL(string: self.selectedRepo!.url)!))
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 1, name: "amangona", url: "https://api.github.com/users/amangona", avatarURL: "https://avatars3.githubusercontent.com/u/20547062?v=4", reposUrl: "https://api.github.com/users/amangona/repos")
        let viewModel = ProfileViewModel(user: user)
        return ProfileView(viewModel: viewModel)
    }
}
