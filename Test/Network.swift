//
//  Network.swift
//  Test
//
//  Created by Олег Савельев on 19.04.2021.
//

import Foundation
import Alamofire

class Loader {
    
    func loadRepo(completion: @escaping ([Repository], String) -> Void){
        
        AF.request("https://api.github.com/repositories?since=0").responseJSON
        { response in
            var nextPageURL = ""
            if let urlResponse = response.response?.headers.value(for: "Link"){
                nextPageURL = self.parse(urlResponse)
            }
            if let objects = response.value,
               let jsonDict = objects as? Array<Dictionary<String,Any>>{
                DispatchQueue.main.async {
                    var repositories: [Repository] = []
                    for items in jsonDict {
                        if let item = Repository(data: items){
                            repositories.append(item)
                        }
                    }
                    completion(repositories, nextPageURL)
                }
            }
        }
    }
    
    func loadMoreRepo(url: String, completion: @escaping ([Repository], String) -> Void){
        AF.request(url).responseJSON
            { response in
            var nextPageURL = ""
            if let urlResponse = response.response?.headers.value(for: "Link"){
                nextPageURL = self.parse(urlResponse)
            }
            
            if let objects = response.value,
               let jsonDict = objects as? Array<Dictionary<String,Any>>{
                DispatchQueue.main.async {
                    var repositories: [Repository] = []
                    for items in jsonDict {
                        if let item = Repository(data: items){
                            repositories.append(item)
                        }
                    }
                    completion(repositories,nextPageURL)
                }
            }
        }
    }

    
    func parse(_ linkHeader: String) -> String{
        var nextPageUrl = ""
        let linkHeaderIn = linkHeader
        let links = linkHeaderIn.components(separatedBy: ", ")
        var arrayLink: [String: String] = [:]
        links.forEach ({
            let components = $0.components(separatedBy:"; ")
                let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            arrayLink[components[1]] = cleanPath
            })

            if let nextPagePath = arrayLink["rel=\"next\""] {
                nextPageUrl = nextPagePath
                print("nextPagePath: \(nextPagePath)")
            }
        return nextPageUrl
    }

}
