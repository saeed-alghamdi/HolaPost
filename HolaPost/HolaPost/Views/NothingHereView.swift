//
//  NothingHereView.swift
//  HolaPost
//
//  Created by RMP on 25/11/1445 AH.
//

import SwiftUI

struct NothingHereView: View {
    
    @Binding var nothingHereFrom: String?
    
    var body: some View {
        
        if let nothingHereFrom = nothingHereFrom {
            
            Text(LocalizedStringKey("28 \(nothingHereFrom)")).bold().foregroundColor(.gray).font(.title3)
            
        }
        
        //Text("No \(nothingHereFrom!)").bold().foregroundColor(.gray).font(.title3)
        
        
    }
    
}

struct NothingHereView_Previews: PreviewProvider {
    static var previews: some View {
        NothingHereView(nothingHereFrom: .constant("Followers"))
    }
}
