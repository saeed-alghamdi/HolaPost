//
//  Post.swift
//  HolaPost
//
//  Created by RMP on 16/10/1445 AH.
//

import Foundation
import SwiftUI


struct Post {
    
    @State var id: String
    @State var image: String
    @State var likes: Int
    @State var owner: Owner
    @State var publishDate: String
    @State var tags: [String]
    @State var text: String
    
    
}
