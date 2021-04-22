//
//  Model.swift
//  Test
//
//  Created by Олег Савельев on 19.04.2021.
//

import Foundation

struct Repository {
    let id: Int64
    let name: String
    let htmlUrl: String
    let owner: Owner
    let description: String
    
    init?(data: [String:Any]) {
        guard let id = data["id"] as? Int64,
              let htmlUrl = data["html_url"] as? String,
              let name = data["name"] as? String,
              let owner = data["owner"] as? NSDictionary,
              let description = data["description"] as? String else { return nil }
        
        let owner1 = Owner(data: owner)
        
        self.id = id
        self.owner = owner1!
        self.name = name
        self.htmlUrl = htmlUrl
        self.description = description
    }
}

struct Owner {
    let login: String
    
    init?(data: NSDictionary){
        guard let login = data["login"] as? String else { return nil }
        self.login = login
    }
}
