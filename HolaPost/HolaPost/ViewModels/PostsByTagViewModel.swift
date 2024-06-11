//
//  TagViewModel.swift
//  HolaPost
//
//  Created by RMP on 22/10/1445 AH.
//

import Foundation
import Alamofire


// Get all posts by tag
class PostsByTagViewModel: ObservableObject {
    
    
    @Published var postsByTag: [Post] = []
    
    var tagname = ""
    
    func getPostsByTagUsingAlamofire(nameOfTag: String) {
        
        if tagname != nameOfTag {
            
            tagname = nameOfTag
            
            let apiURL = "https://dummyapi.io/data/v1/tag/\(tagname)/post"
            
            let headers: HTTPHeaders = [
                
                "app-id":"63e1a64519bd23540fde1b02"
                
            ]
            
            
            AF.request(apiURL, method: .get, headers: headers).responseJSON { data in
                
                
                if let data = data.data {
                    
                    do {
                        
                        let postsByTag = try JSONSerialization.jsonObject(with: data)
                        let dictionaryPosts = postsByTag as! Dictionary<String,Any>
                        let arrayPosts = dictionaryPosts["data"] as? NSArray
                        
                        if let arrayPosts = arrayPosts {
                            
                            for dictionary in arrayPosts {
                                
                                let postDictionary = dictionary as? NSDictionary
                                
                                if let postDictionary = postDictionary {
                                    
                                    if let postId = postDictionary["id"], let image = postDictionary["image"], let likes = postDictionary["likes"], let owner = postDictionary["owner"], let publishDate = postDictionary["publishDate"], let tags = postDictionary["tags"], let text = postDictionary["text"] {
                                        
                                        
                                        let ownerDictionary = owner as! Dictionary<String,Any>
                                        let stringTags = tags as! Array<String>
                                        
                                        if let firstName = ownerDictionary["firstName"], let id = ownerDictionary["id"], let lastName = ownerDictionary["lastName"], let picture = ownerDictionary["picture"], let title = ownerDictionary["title"] {
                                            
                                            DispatchQueue.main.async {
                                                
                                                let newOwner = Owner(firstName: "\(firstName)", id: "\(id)", lastName: "\(lastName)", picture: "\(picture)", title: "\(title)")
                                                
                                                let dateString = "\(publishDate)"
                                                
                                                let indexOfT = dateString.firstIndex(where: { $0 == "T" })
                                                
                                                let fixingDate = dateString[..<indexOfT!].replacingOccurrences(of: "-", with: "/")
                                                
                                                let post = Post(id: "\(postId)", image: "\(image)", likes: Int("\(likes)")!, owner: newOwner, publishDate: fixingDate, tags: stringTags, text: "\(text)")
                                                
                                                
                                                self.postsByTag.append(post)
                                                
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        
                        
                    } catch let somethingWrong {
                        
                        //fatalError(somethingWrong.localizedDescription)
                        
                        /*
                         
                         Do something with this error
                         
                         
                        */
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
    }
    
    func getPostsByTag(nameOfTag: String) {
        
        if tagname != nameOfTag {
            
            tagname = nameOfTag
            
            let apiURL = "https://dummyapi.io/data/v1/tag/\(tagname)/post"
            
            let headers = [
                
                "app-id":"63e1a64519bd23540fde1b02"
                
            ]
            
            let urlRequest = URLRequest(url: URL(string: apiURL) ?? URL(string: "")!)
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = headers
            URLSession(configuration: configuration).dataTask(with: urlRequest) { data, urlResponse, error in
                
                if error != nil {
                    
                    fatalError(error!.localizedDescription)
                    
                } else {
                    
                    if let data = data {
                        
                        do {
                            
                            let postsByTag = try JSONSerialization.jsonObject(with: data)
                            let dictionaryPosts = postsByTag as! Dictionary<String,Any>
                            let arrayPosts = dictionaryPosts["data"] as? NSArray
                            
                            if let arrayPosts = arrayPosts {
                                
                                for dictionary in arrayPosts {
                                    
                                    let postDictionary = dictionary as? NSDictionary
                                    
                                    if let postDictionary = postDictionary {
                                        
                                        if let postId = postDictionary["id"], let image = postDictionary["image"], let likes = postDictionary["likes"], let owner = postDictionary["owner"], let publishDate = postDictionary["publishDate"], let tags = postDictionary["tags"], let text = postDictionary["text"] {
                                            
                                            
                                            let ownerDictionary = owner as! Dictionary<String,Any>
                                            let stringTags = tags as! Array<String>
                                            
                                            if let firstName = ownerDictionary["firstName"], let id = ownerDictionary["id"], let lastName = ownerDictionary["lastName"], let picture = ownerDictionary["picture"], let title = ownerDictionary["title"] {
                                                
                                                DispatchQueue.main.async {
                                                    
                                                    let newOwner = Owner(firstName: "\(firstName)", id: "\(id)", lastName: "\(lastName)", picture: "\(picture)", title: "\(title)")
                                                    
                                                    let dateString = "\(publishDate)"
                                                    
                                                    let indexOfT = dateString.firstIndex(where: { $0 == "T" })
                                                    
                                                    let fixingDate = dateString[..<indexOfT!].replacingOccurrences(of: "-", with: "/")
                                                    
                                                    let post = Post(id: "\(postId)", image: "\(image)", likes: Int("\(likes)")!, owner: newOwner, publishDate: fixingDate, tags: stringTags, text: "\(text)")
                                                    
                                                    
                                                    self.postsByTag.append(post)
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                               
                            }
                            
                            
                            
                        } catch let somethingWrong {
                            
                            fatalError(somethingWrong.localizedDescription)
                            
                        }
                        
                    }
                    
                }
                
            }.resume()
            
        }
        
    }
    
    
}
