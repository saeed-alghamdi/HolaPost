//
//  MainTabView.swift
//  HolaPost
//
//  Created by RMP on 16/10/1445 AH.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        
        TabView {
            
            HomeView().tabItem {
                Image(systemName: "homekit")
            }
            
            AllTagsView().tabItem {
                Image(systemName: "tag.fill")
            }
            
            ProfileView().tabItem {
                Image(systemName: "person")
            }
            
        }
        
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
