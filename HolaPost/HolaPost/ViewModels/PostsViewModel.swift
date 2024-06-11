//
//  PostsViewModel.swift
//  HolaPost
//
//  Created by RMP on 16/10/1445 AH.
//

import Foundation



class PostsViewModel: ObservableObject {
    
    
    @Published var posts: [Post] = []
    
    
    func getAllPostsFromApi() {
        
        let apiURL = "https://dummyapi.io/data/v1/post"
        
        let headers = [
            
            "app-id":"63e1a64519bd23540fde1b02"
            
        ]
        
        let urlRequest = URLRequest(url: URL(string: apiURL)!)
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        URLSession(configuration: configuration).dataTask(with: urlRequest) { data, urlResponse, urlError in
            
            if urlError != nil {
                
                fatalError(urlError!.localizedDescription)
                
            } else {
                
                if let data = data {
                    
                    do {
                        
                        let jsonData = try JSONSerialization.jsonObject(with: data)
                        //let jsonToDictionary = jsonData as! Dictionary<String,Any>
                        let jsonToNSDictionary = jsonData as! NSDictionary
                        let dictionaryToNSArray = jsonToNSDictionary["data"] as? NSArray
                        
                        if let dictionaryToNSArray = dictionaryToNSArray {
                            
                            for dictionary in dictionaryToNSArray {
                                
                                let postDictionary = dictionary as! NSDictionary
                                
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
                                            
                                            
                                            self.posts.append(post)
                                            
                                            self.posts.shuffle()
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    } catch let jsonError {
                        
                        fatalError(jsonError.localizedDescription)
                        
                    }
                    
                }
                
                
            }
            
        }.resume()
        
        
    }
    
}
