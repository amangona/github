//
//  SearchViewModel.swift
//  github
//
//  Created by abe on 4/13/20.
//  Copyright © 2020 abe. All rights reserved.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    private let api = API()
    @Published var users = [User]()
    private var subscriptions = Set<AnyCancellable>()
    @Published var searchText = ""
    
    init() {
        $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
            print(completion)
        }) { (value) in
            if value != "" {
                self.search(name: value)
            }
        }.store(in: &subscriptions)
    }
    
    func search(name: String) {
        api.searchUser(with: name)
            .map(\.items)
            .sink(receiveCompletion: { (completion) in
                print(completion)
            }) { (value) in
                DispatchQueue.main.async {
                    self.users = value
                }
        }.store(in: &subscriptions)
    }

    
    
}
