//
//  SignUpView.swift
//  HolaPost
//
//  Created by RMP on 16/10/1445 AH.
//

import SwiftUI

struct SignUpView: View {
    
    
    let currentWindow = UIWindow()
    
    @State var emailTextField = "example@example.com"
    @State var passwordTextField = "pa$$word"
    @State var confirmPasswordTextField = "pa$$word"
    
    @AppStorage("In") var signedIn: Bool?
    
    @State var signUpSuccessfully: Bool = false
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                Text(LocalizedStringKey("8")).font(.title).textFieldStyle(.plain).multilineTextAlignment(.center)
                
                VStack(spacing: -10) {
                    
                    TextField(LocalizedStringKey("9"), text: $emailTextField).tint(.primary).autocorrectionDisabled(true).multilineTextAlignment(.leading).font(.headline).padding().padding().overlay() {
                        
                        RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray).padding()
                        
                    }
                    
                    SecureField(LocalizedStringKey("10"), text: $passwordTextField).tint(.primary).autocorrectionDisabled(true).multilineTextAlignment(.leading).font(.headline).padding().padding().overlay() {
                        
                        RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray).padding()
                        
                    }
                    
                    
                    SecureField(LocalizedStringKey("11"), text: $confirmPasswordTextField).tint(.primary).autocorrectionDisabled(true).multilineTextAlignment(.leading).font(.headline).padding().padding().overlay() {
                        
                        RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray).padding()
                        
                    }
                    
                }
                
                
                Button {
                    
                    signUpSuccessfully = true
                    signedIn = true
                    
                    
                } label: {
                    
                    RoundedRectangle(cornerRadius: 16).foregroundColor(.blue).overlay {
                        Text(LocalizedStringKey("12")).font(.headline).fontWeight(.bold).foregroundColor(.white)
                    }.frame(width: currentWindow.screen.bounds.width - 30, height: currentWindow.screen.scale + 60, alignment: .center)
                    
                }.fullScreenCover(isPresented: $signUpSuccessfully) {
                    MainTabView()
                }
               
            }.navigationTitle(Text(LocalizedStringKey("13")))
            
        }
        
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
