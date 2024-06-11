//
//  HomeView.swift
//  HolaPost
//
//  Created by RMP on 17/10/1445 AH.
//

import SwiftUI
import SDWebImageSwiftUI


// Share ViewController
struct MyActivityController: UIViewControllerRepresentable {
    
    let copyURL: String
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // ...
    }
    
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let activityController = UIActivityViewController(activityItems: [copyURL], applicationActivities: nil)
        activityController.allowsProminentActivity = true
        return activityController
        
        
    }
    
    
    
    
}

struct HomeView: View {
    
    init() {
        
        posts.getAllPostsFromApi()
        
    }
    
    
    let currentWindow = UIWindow()
    
    @ObservedObject var posts = PostsViewModel()
    
    @State var isFavorite = false
    
    @State var isAnimatingImage = true
    
    @State var showingShareController: Bool = false
    
    @State var newLikes = 0
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                ForEach(posts.posts, id: \.id) { index in
                    
                    
                    VStack(spacing: -10) {
                        
                        HStack {
                            
                            WebImage(url: URL(string: index.owner.picture), isAnimating: $isAnimatingImage).resizable().frame(width: 40, height: 40, alignment: .trailing).cornerRadius(40 / 2).aspectRatio(contentMode: .fit)
                             
                            
                            NavigationLink {
                                
                                UserAccountView(userID: index.owner.id)
                                
                            } label: {
                                
                                Text("\(index.owner.firstName) \(index.owner.lastName)").foregroundColor(.primary)
                                
                            }
                            
                            Spacer()
                            
                            
                            Button {
                                
                                showingShareController = true
                                
                            } label: {
                                
                                Circle().foregroundColor(.gray).opacity(0.25).frame(width: 30, height: 30, alignment: .center).overlay {
                                    
                                    Image(systemName: "ellipsis").foregroundColor(.primary)
                                    
                                }
                                
                            }.sheet(isPresented: $showingShareController) {
                                
                                MyActivityController(copyURL: index.image)
                                
                            }

                            
                            /*Button("Share") {
                                
                                showingShareController = true
                                
                            }.sheet(isPresented: $showingShareController) {
                                
                                MyActivityController(copyURL: index.image)
                                
                            }*/
                            
                            
                        }.padding()
                        
                        VStack {
                            
                            WebImage(url: URL(string: index.image), isAnimating: $isAnimatingImage).resizable().frame(width: currentWindow.screen.bounds.width, height: currentWindow.screen.bounds.height / 1.8, alignment: .center).aspectRatio(contentMode: .fit)
                            
                            
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
                                        
                                        if isFavorite {
                                            
                                            Text(LocalizedStringKey("14 \(String(stringLiteral: "\(index.likes + 1)"))"))
                                            
                                        } else {
                                            
                                            Text(LocalizedStringKey("14 \(String(stringLiteral: "\(index.likes)"))"))
                                            
                                        }
                                        
                                    }
                                    
                                }.padding()
                                
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(index.text).lineLimit(0)
                                    HStack {
                                        
                                        Text(LocalizedStringKey("15"))
                                        
                                        ForEach(index.tags, id: \.hashValue) { tag in
                                            
                                            
                                            NavigationLink("#\(tag)") {
                                                PostsByTagView(navigationTitle: tag, tagTitle: tag)
                                            }
                                            
                                            /*Button("#\(tag)") {
                                                // ...
                                            }*/
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    Text(LocalizedStringKey("16: \(index.publishDate)"))
                                    
                                    
                                }.padding()
                                
                            }
                            
                        }.padding(.bottom, 70)
                       
                    }
                    
                }
                
            }.navigationTitle(Text(LocalizedStringKey("17"))).navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
