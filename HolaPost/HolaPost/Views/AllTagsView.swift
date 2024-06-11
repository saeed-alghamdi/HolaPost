//
//  AllTagsView.swift
//  HolaPost
//
//  Created by RMP on 22/10/1445 AH.
//

import SwiftUI

struct AllTagsView: View {
    
    init() {
        
        allTags.getAllTags()
        
    }
    
    @ObservedObject var allTags = AllTagsViewModel()
    
    @State private var searchTerm: String = ""
    
    var body: some View {
        
        
        NavigationView {
            
            if searchableMethod.isEmpty {
                
                Text(LocalizedStringKey(stringLiteral: "20"))
                
            } else {
                
                List(searchableMethod, id: \.tag) { index in
                    
                    NavigationLink(index.tag) {
                        
                        
                        PostsByTagView(navigationTitle: index.tag, tagTitle: index.tag)
                        
                        
                    }
                    
                }.searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: Text(LocalizedStringKey("21"))).navigationTitle(LocalizedStringKey("22")).navigationBarTitleDisplayMode(.inline)
                
            }
            
            
        }
        
    }
    
}


// Method for search
extension AllTagsView {
    
    var searchableMethod: [Tag] {
        
        guard !searchTerm.isEmpty else { return allTags.tags }
        
        return allTags.tags.filter { $0.tag.localizedCaseInsensitiveContains(searchTerm) }
        
    }
    
}


struct AllTagsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTagsView()
    }
}
