//
//  TagsViewModel.swift
//  HolaPost
//
//  Created by RMP on 22/10/1445 AH.
//

import Foundation


class AllTagsViewModel: ObservableObject {
    
    @Published var tags: [Tag] = []
    
    func getAllTags() {
        
        let apiURL = "https://dummyapi.io/data/v1/tag"
        
        let headers = [
            
            "app-id":"63e1a64519bd23540fde1b02"
            
        ]
        
        let urlRequest = URLRequest(url: URL(string: apiURL)!)
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        URLSession(configuration: configuration).dataTask(with: urlRequest) { data, urlResponse, error in
            
            if error != nil {
                
                fatalError(error!.localizedDescription)
                
            } else {
                
                if let dataTags = data {
                    
                    do {
                        
                        let insideTags = try JSONSerialization.jsonObject(with: dataTags)
                        let dictionaryTags = insideTags as! Dictionary<String,Any>
                        let arrayOfTags = dictionaryTags["data"] as! Array<Any>
                        
                        for element in arrayOfTags {
                            
                            DispatchQueue.main.async {
                                
                                var elementToString = element as? String
                                
                                if elementToString != nil {
                                    
                                    if var elementToString = elementToString {
                                        
                                        elementToString.removeAll { $0 == "#"}
                                        
                                        if !elementToString.contains(where: { $0 == " "}) && elementToString.count < 6 {
                                            
                                            let tag = Tag(tag: elementToString)
                                            self.tags.append(tag)
                                            
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    } catch let somethingWrong {
                        
                        fatalError("something wrong: \(somethingWrong.localizedDescription)")
                        
                    }
                    
                }
                
            }
            
        }.resume()
        
    }
    
}
