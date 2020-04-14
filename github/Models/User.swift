//
//  User.swift
//  github
//
//  Created by abe on 4/13/20.
//  Copyright © 2020 abe. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let url: String
    let avatarURL: String
    let reposUrl: String
        
    enum CodingKeys: String, CodingKey {
      case id
      case name = "login"
      case url
      case avatarURL = "avatar_url"
      case reposUrl = "repos_url"
    }
}

struct Response: Codable {
     var items: [User]
}

struct Repo: Codable, Identifiable{
    let id: Int
    let name: String
    let url: String
    let forks: Int
    let stars: Int
    enum CodingKeys: String, CodingKey {
      case id
      case name
      case url = "html_url"
      case forks
      case stars = "stargazers_count"
    }
}

struct Profile: Codable {
    
    let id: Int
    let email: String?
    let name: String
    let url: String
    let reposURL: String
    let avatarURL: String
    let bio: String?
    let followers: Int
    let following: Int
    let joinDate: String
    let htmlURL: String
    
    enum CodingKeys: String, CodingKey {
      case id
      case email
      case name = "login"
      case reposURL = "repos_url"
      case avatarURL = "avatar_url"
      case bio
      case followers
      case following
      case url
      case joinDate = "created_at"
      case htmlURL = "html_url"
    }
    
}
