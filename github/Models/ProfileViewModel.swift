//
//  ProfileViewModel.swift
//  github
//
//  Created by abe on 4/14/20.
//  Copyright © 2020 abe. All rights reserved.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var profile: Profile?
    private var subscriptions = Set<AnyCancellable>()
    private let api = API()
    @Published var repos = [Repo]()
    
    
    init(user: User) {
        api.getProfile(for: user)
            .sink(receiveCompletion: { (completion) in
                print("profile completetion: ", completion)
            }) { value in
                DispatchQueue.main.async {
                    self.profile = value
                }
        }.store(in: &subscriptions)
        
        api.getRepos(for: user).sink(receiveCompletion: { (completion) in
            print(completion)
        }) { (value) in
            DispatchQueue.main.async {
                self.repos = value
            }
        }.store(in: &subscriptions)
    }
}
