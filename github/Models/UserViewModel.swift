//
//  UserViewModel.swift
//  github
//
//  Created by abe on 4/13/20.
//  Copyright © 2020 abe. All rights reserved.
//

import Foundation
import SDWebImageSwiftUI
import Combine

class UserViewModel: ObservableObject {
    var name: String
    let avatarURL: URL
    @Published var repos = [Repo]()
    private var subscriptions = Set<AnyCancellable>()
    private let api = API()
    var user: User
    
    
    init(user: User) {
        self.user = user
        name = user.name
        avatarURL = URL(string: user.avatarURL)!
    }
    func getRepos() {
        api.getRepos(for: self.user).sink(receiveCompletion: { (completion) in
            print(completion)
        }) { (value) in
            DispatchQueue.main.async {
                self.repos = value
            }
        }.store(in: &subscriptions)
    }
}
