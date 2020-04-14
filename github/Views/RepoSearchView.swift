//
//  RepoSearchView.swift
//  github
//
//  Created by abe on 4/13/20.
//  Copyright © 2020 abe. All rights reserved.
//

import SwiftUI

struct RepoSearchView: View {
    @State var searchText = ""
    @ObservedObject var viewModel: ProfileViewModel
    var selection: ((Repo)->())
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
            List {
                ForEach(self.viewModel.repos.filter {
                    self.searchText.isEmpty ? true : $0.name.lowercased().contains(self.searchText.lowercased())
                }) { repo in
                    HStack {
                        Text(repo.name)
                            .padding()
                            .font(.headline)
                        Spacer()
                        VStack {
                            Text("\(repo.forks) Forks")
                            Text("\(repo.stars) Stars")
                        }.padding()
                    }.onTapGesture {
                        self.selection(repo)
                    }
                }
            }
            .resignKeyboardOnDragGesture()
        }
    }
}

struct RepoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 1, name: "amangona", url: "https://api.github.com/users/amangona", avatarURL: "https://avatars3.githubusercontent.com/u/20547062?v=4", reposUrl: "https://api.github.com/users/amangona/repos")
        let viewModel = ProfileViewModel(user: user)
        return RepoSearchView(viewModel: viewModel) { repo in
            print(repo)
        }
    }
}
