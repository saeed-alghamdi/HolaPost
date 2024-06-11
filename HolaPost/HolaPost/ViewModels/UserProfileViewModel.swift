//
//  UserProfileViewModel.swift
//  HolaPost
//
//  Created by RMP on 16/10/1445 AH.
//

import Foundation
import Alamofire


/*
 
 -- HERE USE ALAMOFIRE FOR DOWNLOAD EATCH OF ALL POSTS AND USER INFORMATION --
 
*/

class UserProfileViewModel: ObservableObject {
    
    @Published var userInformation: [User] = []
    
    @Published var posts: [Post] = []
    
    var userID = ""
    
    
    func getAllUserInformationUsingAlamofire(id: String) {
        
        if userID != id {
            
            userID = id
            
            let apiURL = "https://dummyapi.io/data/v1/user/"
            
            let headers: HTTPHeaders = [
                
                "app-id":"63e1a64519bd23540fde1b02"
                
            ]
            
            AF.request(apiURL + userID, method: .get, headers: headers).responseJSON { result in
                
                let dataDictionary = result.value as! Dictionary<String,Any>
                
                let locationDictionary = dataDictionary["location"] as! Dictionary<String,Any>
                
                
                if let dateOfBirth = dataDictionary["dateOfBirth"],
                   let email = dataDictionary["email"],
                   let firstName = dataDictionary["firstName"],
                   let gender = dataDictionary["gender"],
                   let id = dataDictionary["id"],
                   let lastName = dataDictionary["lastName"],
                   let phone = dataDictionary["phone"],
                   let registerDate = dataDictionary["registerDate"],
                   let title = dataDictionary["title"],
                   let updateDate = dataDictionary["updatedDate"], let picture = dataDictionary["picture"] {
                    
                    
                    if let street = locationDictionary["street"], let timezone = locationDictionary["timezone"], let city = locationDictionary["city"], let state = locationDictionary["state"], let country = locationDictionary["country"] {
                        
                        
                        DispatchQueue.main.async {
                            
                            let newLocation = Location(state: "\(state)", city: "\(city)", timezone: "\(timezone)", country: "\(country)", street: "\(street)")
                            
                            
                            
                            let dateString1 = "\(registerDate)"
                            
                            let indexOfT1 = dateString1.firstIndex(where: { $0 == "T" })
                            
                            let fixingDate1 = dateString1[..<indexOfT1!].replacingOccurrences(of: "-", with: "/")
                            
                            
                            
                            let dateString2 = "\(dateOfBirth)"
                            
                            let indexOfT2 = dateString2.firstIndex(where: { $0 == "T" })
                            
                            let fixingDate2 = dateString2[..<indexOfT2!].replacingOccurrences(of: "-", with: "/")
                            
                            
                            
                            let dateString3 = "\(updateDate)"
                            
                            let indexOfT3 = dateString3.firstIndex(where: { $0 == "T" })
                            
                            let fixingDate3 = dateString3[..<indexOfT3!].replacingOccurrences(of: "-", with: "/")
                            
                            
                            let newUser = User(dateOfBirth: fixingDate2, email: "\(email)", firstName: "\(firstName)", gender: "\(gender)", id: "\(id)", lastName: "\(lastName)", location: newLocation, phone: "\(phone)", registerDate: fixingDate1, title: "\(title)", updatedDate: fixingDate3, picture: "\(picture)")
                            
                            self.userInformation.append(newUser)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    /*func getAllUserInformation(id: String) {
        
        if userID != id {
            
            userID = id
            
            let apiURL = "https://dummyapi.io/data/v1/user/"
            
            let headers = [
                
                "app-id":"63e1a64519bd23540fde1b02"
                
            ]
            
            let urlRequest = URLRequest(url: URL(string: apiURL + userID)!)
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = headers
            
            URLSession(configuration: configuration).dataTask(with: urlRequest) { data, urlResponse, urlError in
                
                if urlError != nil {
                    
                    fatalError(urlError!.localizedDescription)
                    
                } else {
                    
                    if let data = data {
                        
                        do {
                            
                            let jsonData = try JSONSerialization.jsonObject(with: data)
                            let dataDictionary = jsonData as! NSDictionary
                            
                            let locationDictionary = dataDictionary["location"] as! Dictionary<String,Any>
                            
                            
                            if let dateOfBirth = dataDictionary["dateOfBirth"],
                               let email = dataDictionary["email"],
                               let firstName = dataDictionary["firstName"],
                               let gender = dataDictionary["gender"],
                               let id = dataDictionary["id"],
                               let lastName = dataDictionary["lastName"],
                               let phone = dataDictionary["phone"],
                               let registerDate = dataDictionary["registerDate"],
                               let title = dataDictionary["title"],
                               let updateDate = dataDictionary["updatedDate"], let picture = dataDictionary["picture"] {
                                
                                
                                if let street = locationDictionary["street"], let timezone = locationDictionary["timezone"], let city = locationDictionary["city"], let state = locationDictionary["state"], let country = locationDictionary["country"] {
                                    
                                    
                                    DispatchQueue.main.async {
                                        
                                        let newLocation = Location(state: "\(state)", city: "\(city)", timezone: "\(timezone)", country: "\(country)", street: "\(street)")
                                        
                                        
                                        
                                        let dateString1 = "\(registerDate)"
                                        
                                        let indexOfT1 = dateString1.firstIndex(where: { $0 == "T" })
                                        
                                        let fixingDate1 = dateString1[..<indexOfT1!].replacingOccurrences(of: "-", with: "/")
                                        
                                        
                                        
                                        let dateString2 = "\(dateOfBirth)"
                                        
                                        let indexOfT2 = dateString2.firstIndex(where: { $0 == "T" })
                                        
                                        let fixingDate2 = dateString2[..<indexOfT2!].replacingOccurrences(of: "-", with: "/")
                                        
                                        
                                        
                                        let dateString3 = "\(updateDate)"
                                        
                                        let indexOfT3 = dateString3.firstIndex(where: { $0 == "T" })
                                        
                                        let fixingDate3 = dateString3[..<indexOfT3!].replacingOccurrences(of: "-", with: "/")
                                        
                                        
                                        let newUser = User(dateOfBirth: fixingDate2, email: "\(email)", firstName: "\(firstName)", gender: "\(gender)", id: "\(id)", lastName: "\(lastName)", location: newLocation, phone: "\(phone)", registerDate: fixingDate1, title: "\(title)", updatedDate: fixingDate3, picture: "\(picture)")
                                        
                                        self.userInformation.append(newUser)
                                        
                                        
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
        
    }*/
    
    
    func getAllPostByUserIdUsingAlamofire(id: String) {
        
        let apiURL = "https://dummyapi.io/data/v1/user/"
        
        let headers: HTTPHeaders = [
            
            "app-id":"63e1a64519bd23540fde1b02"
            
        ]
        
        
        AF.request(apiURL + userID + "/post", method: .get, headers: headers).responseJSON { jsonData in
            
            if let dictionary = jsonData.value {
                
                let dataDictionary = dictionary as! Dictionary<String,Any>
                
                let dataArray = dataDictionary["data"]
                
                if let dataArray = dataArray as? NSArray {
                    
                    for dict in dataArray {
                        
                        let postDictionary = dict as! Dictionary<String,Any>
                        
                        
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
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    /*func getAllPostByUserId(id: String) {
        
        
        if userID != id {
            
            userID = id
            
            let apiURL = "https://dummyapi.io/data/v1/user/"
            
            let headers = [
                
                "app-id":"63e1a64519bd23540fde1b02"
                
            ]
            
            
            let urlRequest = URLRequest(url: URL(string: apiURL + userID + "/post")!)
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = headers
            
            URLSession(configuration: configuration).dataTask(with: urlRequest) { data, urlResponse, urlError in
                
                if urlError != nil {
                    
                    fatalError(urlError!.localizedDescription)
                    
                } else {
                    
                    if let data = data {
                        
                        do {
                            
                            let jsonData = try JSONSerialization.jsonObject(with: data)
                            let dataDictionary = jsonData as! NSDictionary
                            
                            let dataArray = dataDictionary["data"]
                            
                            if let dataArray = dataArray as? NSArray {
                                
                                for dict in dataArray {
                                    
                                    let postDictionary = dict as! Dictionary<String,Any>
                                    
                                    
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
                                                
                                                print(" ------> all posts before add to array: \(post)")
                                                
                                                self.posts.append(post)
                                                
                                                print(" ---------> array after add post to array: \(self.posts)")
                                                
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
        
        
    }*/
    
}



