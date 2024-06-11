//
//  SinglePostView.swift
//  HolaPost
//
//  Created by RMP on 01/11/1445 AH.
//

import SwiftUI
import SDWebImageSwiftUI

struct SinglePostView: View {
    
    let currentWindow = UIWindow()
    
    let post: Post
    
    @State var isAnimatingImage = true
    @State var isFavorite: Bool = false
    
    @State var showingShareController: Bool = false
    
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: -10) {
                
                HStack {
                    
                    WebImage(url: URL(string: post.owner.picture), isAnimating: $isAnimatingImage).resizable().frame(width: 40, height: 40, alignment: .trailing).cornerRadius(40 / 2).aspectRatio(contentMode: .fit)
                    
                    
                    NavigationLink {
                        
                        UserAccountView(userID: post.owner.id)
                        
                        
                    } label: {
                        
                        Text("\(post.owner.firstName) \(post.owner.lastName)").foregroundColor(.primary)
                        
                    }

                    
                    Spacer()
                    
                    Button {
                        
                        showingShareController = true
                        
                    } label: {
                        
                        Circle().foregroundColor(.gray).opacity(0.25).frame(width: 30, height: 30, alignment: .center).overlay {
                            
                            Image(systemName: "ellipsis").foregroundColor(.primary)
                            
                        }
                        
                    }.sheet(isPresented: $showingShareController) {
                        
                        MyActivityController(copyURL: post.image)
                        
                    }
                    
                }.padding()
                
                VStack {
                    
                    WebImage(url: URL(string: post.image), isAnimating: $isAnimatingImage).resizable().frame(width: currentWindow.screen.bounds.width, height: currentWindow.screen.bounds.height / 1.8, alignment: .center).aspectRatio(contentMode: .fit)
                    
                    
                    VStack(alignment: .leading, spacing: -20) {
                        
                        HStack {
                            
                            HStack {
                                
                                Button {
                                    
                                    isFavorite.toggle()
                                    
                                } label: {
                                    
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit).frame(width: 25, height: 25).foregroundColor(isFavorite ? .red : .gray)
                                    
                                }
                                
                                /*if isFavorite {
                                    
                                    
                                    Text("\(post.likes + 1) لايك")
                                    
                                } else {
                                    
                                    Text("\(post.likes) لايك")
                                    
                                }*/
                                
                                if isFavorite {
                                    
                                    Text(LocalizedStringKey("14 \(String(stringLiteral: "\(post.likes + 1)"))"))
                                    
                                } else {
                                    
                                    Text(LocalizedStringKey("14 \(String(stringLiteral: "\(post.likes)"))"))
                                    
                                }
                                
                                
                            }
                            
                        }.padding()
                        
                        
                        VStack(alignment: .leading) {
                            
                            Text(post.text).lineLimit(0)
                            
                            HStack {
                                
                                
                                Text(LocalizedStringKey("15"))
                                
                                ForEach(post.tags, id: \.hashValue) { tag in
                                    
                                    
                                    NavigationLink("#\(tag)") {
                                        PostsByTagView(navigationTitle: tag, tagTitle: tag)
                                    }
                                    
                                    /*Button("#\(tag)") {
                                        // ...
                                    }*/
                                    
                                }
                                
                            }
                            
                            Text(LocalizedStringKey("16: \(post.publishDate)"))
                            
                            
                        }.padding()
                        
                    }
                    
                }.padding(.bottom, 70)
               
            }
            
        }
        
    }
    
}

