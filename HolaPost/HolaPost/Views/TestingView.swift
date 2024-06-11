//
//  TestingView.swift
//  HolaPost
//
//  Created by RMP on 01/11/1445 AH.
//

import SwiftUI



struct TestingView: View {
    
    var body: some View {
        
        VStack {
            
            Text("first").font(.title)
            Text("second").font(.title2)
            Text("third").font(.title3)
            
        }
        
    }
    
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}
