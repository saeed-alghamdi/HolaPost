//
//  TagView.swift
//  HolaPost
//
//  Created by RMP on 22/10/1445 AH.
//

import SwiftUI
import SDWebImageSwiftUI



struct MyActivityWaitingIndicatorView: UIViewRepresentable {
    
    let isStopp: Bool
    
    init(isStopp: Bool) {
        self.isStopp = isStopp
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
        
        if isStopp == true {
            
            uiView.stopAnimating()
            
        } else {
            
            uiView.startAnimating()
            
        }
        
        
    }
    
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        return activityIndicator
        
        
    }
    
    
    
}


struct PostsByTagView: View {
    
    let navigationTitle: String
    
    let tagTitle: String
    
    let gridItem = GridItem(.fixed(120), spacing: 3, alignment: .center)
    
    @State var noResults = LocalizedStringKey("18")
    
    @State var stopIndicator: Bool = false
    
    @State var counter: Int = 0
    
    
    @ObservedObject var postsByTagViewModel = PostsByTagViewModel()
    
    var body: some View {
        
        ScrollView {
            
            if postsByTagViewModel.postsByTag.isEmpty {
                
                VStack {
                    
                    MyActivityWaitingIndicatorView(isStopp: stopIndicator)
                    Text(noResults).font(.title3).bold()
                    
                }.padding(.top, UIScreen.main.bounds.midY / 1.2)
                
                
            } else {
                
                LazyVGrid(columns: [gridItem, gridItem, gridItem], spacing: 3) {
                    
                    ForEach(postsByTagViewModel.postsByTag, id:\.id) { index in
                        
                        NavigationLink {
                            
                            
                            let owner = Owner(firstName: index.owner.firstName, id: index.owner.id, lastName: index.owner.lastName, picture: index.owner.picture, title: index.owner.title)
                            
                            let post = Post(id: index.id, image: index.image, likes: index.likes, owner: owner, publishDate: index.publishDate, tags: index.tags, text: index.text)
                            
                            
                            SinglePostView(post: post)
                            
                            //SinglePostView(post: <#Post#>, ownerPicture: index.owner.picture, ownerID: index.owner.id, ownerFirstname: index.owner.firstName, ownerLastname: index.owner.lastName, postImage: index.image, commentText: index.text, tags: index.tags, likes: index.likes, postPublishDate: index.publishDate)
                            
                            
                        } label: {
                            
                            WebImage(url: URL(string: index.image)!).resizable().aspectRatio(contentMode: .fill).frame(width: 120, height: 120, alignment: .center).clipShape(RoundedRectangle(cornerRadius: 0))
                            
                        }

                    }
                    
                }
                
            }
            
        }.onAppear {
            
            //postsByTagViewModel.getPostsByTag(nameOfTag: tagTitle)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { insider in
                
                counter += 1
                
                if counter == 4 {
                    
                    noResults = LocalizedStringKey("19")
                    stopIndicator = true
                    insider.invalidate()
                    
                }
                
            }
            
            
            postsByTagViewModel.getPostsByTagUsingAlamofire(nameOfTag: tagTitle)
            
            
            
        }.navigationTitle("#\(navigationTitle)").navigationBarTitleDisplayMode(.inline)
        
    }
    
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        PostsByTagView(navigationTitle: "doggy", tagTitle: "doggy")
    }
}
