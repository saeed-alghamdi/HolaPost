//
//  HolaPostApp.swift
//  HolaPost
//
//  Created by RMP on 16/10/1445 AH.
//

import SwiftUI

@main
struct HolaPostApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            if UserDefaults.standard.object(forKey: "In") != nil {
                
                MainTabView()
                
            } else {
                
                LoginInView()
                
            }
            
            
        }
        
    }
}
