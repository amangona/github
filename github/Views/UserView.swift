//
//  UserView.swift
//  github
//
//  Created by abe on 4/13/20.
//  Copyright © 2020 abe. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel
    var body: some View {
        HStack {
            WebImage(url: viewModel.avatarURL)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding()
            Text(viewModel.name)
                .padding()
            Spacer()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 1, name: "amangona", url: "https://api.github.com/users/amangona", avatarURL: "https://avatars3.githubusercontent.com/u/20547062?v=4", reposUrl: "https://api.github.com/users/amangona/repos")
        let viewModel = UserViewModel(user: user)
        return UserView(viewModel: viewModel)
    }
}
