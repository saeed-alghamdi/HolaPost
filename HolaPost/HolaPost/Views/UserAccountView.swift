//
//  UserAccountView.swift
//  HolaPost
//
//  Created by RMP on 17/10/1445 AH.
//


import SwiftUI
import SDWebImageSwiftUI



struct UserAccountView: View {
    
    let userID: String
    
    let currentWindow = UIWindow()
    
    let gridItem = GridItem(.fixed(120), spacing: 3, alignment: .center)
    
    @StateObject var userProfileViewModel = UserProfileViewModel()
    
    @State var followUnfollow: Bool = false
    @State var pictureAnimation: Bool = true
    
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                
                HStack {
                    
                    let url = URL(string: userProfileViewModel.userInformation.first?.picture ?? "")
                    
                    if let url = url {
                        
                        WebImage(url: url).resizable().aspectRatio(contentMode: .fit).frame(width: currentWindow.bounds.width / 5, height: currentWindow.bounds.width / 5, alignment: .center).clipShape(Circle())
                        
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("\(userProfileViewModel.posts.count)").bold()
                        Text("Posts").bold()
                        
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("\(Int.random(in: 0...999))K").bold()
                        Text("Followers").bold()
                        
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("0").bold()
                        Text("Following").bold()
                        
                    }
                    
                }.padding()
                
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        
                        
                        ForEach(userProfileViewModel.userInformation, id: \.id) { index in
                            
                            Text("\(index.firstName) \(index.lastName)").bold().foregroundColor(.primary).font(.headline)
                            
                            Text("ℹ️ Personal Account").foregroundColor(.gray).font(.caption)
                            
                            Text("🍼 \(index.dateOfBirth)").foregroundColor(.primary).font(.footnote)
                            
                            Text("📩 \(index.email)").foregroundColor(.primary).font(.footnote)
                            if index.gender == "female" {
                                Text("👩‍🔧 \(index.gender)").foregroundColor(.primary).font(.footnote)
                            } else {
                                Text("👨‍🦰 \(index.gender)").foregroundColor(.primary).font(.footnote)
                            }
                            
                            Text("📞 \(index.phone)").foregroundColor(.primary).font(.footnote)
                            Text("📍 \(index.location.street)").foregroundColor(.primary).font(.footnote)
                            
                        }
                        
                        Link(destination: URL(string: "https://www.example.com/")!) {
                            
                            Text("🌎 https://www.example.com/").foregroundColor(.primary).font(.footnote)
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                }.padding()
                
                
                VStack {
                    
                    Button {
                        
                        withAnimation(.easeIn) {
                            
                            followUnfollow.toggle()
                            
                        }
                        
                    } label: {
                        
                        RoundedRectangle(cornerRadius: 11).foregroundColor(followUnfollow ? .gray.opacity(0.25) : .accentColor).overlay {
                            Text(LocalizedStringKey(followUnfollow ? "26" : "27")).font(.headline).fontWeight(.bold).foregroundColor(followUnfollow ? .primary : .white)
                        }.frame(width: UIScreen.main.bounds.width / 1.1, height: currentWindow.screen.scale + 40, alignment: .center)
                        
                        
                        
                        
                    }
                    
                    

                }.padding(.bottom, 10)
                
                
                LazyVGrid(columns: [gridItem, gridItem, gridItem], spacing: 3) {
                    
                    ForEach(userProfileViewModel.posts, id: \.id) { index in
                        
                        NavigationLink {
                            
                            
                            let owner = Owner(firstName: index.owner.firstName, id: index.owner.id, lastName: index.owner.lastName, picture: index.owner.picture, title: index.owner.title)
                            
                            let post = Post(id: index.id, image: index.image, likes: index.likes, owner: owner, publishDate: index.publishDate, tags: index.tags, text: index.text)
                            
                            
                            SinglePostView(post: post)
                            
                            
                            
                        } label: {
                            
                            WebImage(url: URL(string: index.image)!).resizable().aspectRatio(contentMode: .fill).frame(width: 120, height: 120, alignment: .center).clipShape(RoundedRectangle(cornerRadius: 0))
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
        }.onAppear {
            
            /*
             
             --- THIS METHODS FOR URLSession ---
             
             //userProfileViewModel.getAllUserInformation(id: userID)
             
             //userProfileViewModel.getAllPostByUserId(id: userID)
             
             
             */
            
            
            // ---- *** ALAMOFIRE API *** ----
            userProfileViewModel.getAllUserInformationUsingAlamofire(id: userID)
            
            userProfileViewModel.getAllPostByUserIdUsingAlamofire(id: userID)
            
        }
    }
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView(userID: "")
        
        
    }
}
