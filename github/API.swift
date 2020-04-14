//
//  API.swift
//  github
//
//  Created by abe on 4/13/20.
//  Copyright © 2020 abe. All rights reserved.
//

import Foundation
import Combine

struct API {
    enum EndPoints {
        
        static let baseURL = URL(string: "https://api.github.com/search/")!
        
        case users(String)
        case repos
        
//        var urlComponents = URLComponents(string: "https://api.github.com/search/users")!
//        urlComponents.queryItems = [
//            URLQueryItem(name: "q", value: name)
//        ]
        
        var url: URL {
            switch self {
                case .users(let name):
                    return EndPoints.baseURL.appendingPathComponent("users?q=\(name)")
                case .repos:
                    return EndPoints.baseURL.appendingPathComponent("repositories")
            }
        }
    }
    
    let maxUsers = 10
    
    private let apiQueue = DispatchQueue(label: "Search", qos: .default, attributes: .concurrent)
//    private let apiQueue = DispatchQueue(label: "Search", qos: .default, attributes: .concurrent) // see is this increases performance
    private let decoder = JSONDecoder()
    
    func searchUser(with name: String) -> AnyPublisher<Response,Error> {
        var urlComponents = URLComponents(string: "https://api.github.com/search/users")!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: name)
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: Response.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getRepos(for user: User) -> AnyPublisher<[Repo], Error> {
        let url = URL(string: user.reposUrl)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: [Repo].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getProfile(for user: User) -> AnyPublisher<Profile, Error> {
        let url = URL(string: user.url)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: Profile.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
}
