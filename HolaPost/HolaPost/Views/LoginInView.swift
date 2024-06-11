//
//  LoginInSignUpView.swift
//  HolaPost
//
//  Created by RMP on 16/10/1445 AH.
//

import SwiftUI

struct LoginInView: View {
    
    
    let currentWindow = UIWindow()
    
    @State var emailTextField = "example@example.com"
    @State var passwordTextField = "pa$$word"
    
    @AppStorage("In") var loggedIn: Bool?
    
    @State var showingMainTabView: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    VStack(spacing: 0) {
                        
                        
                        Text(LocalizedStringKey("1")).font(.title3).fontWeight(.semibold)
                        
                        Text(LocalizedStringKey("2")).padding([.bottom, .top], 20)
                        
                        
                        TextField(LocalizedStringKey("3"), text: $emailTextField).tint(.primary).autocorrectionDisabled(true).multilineTextAlignment(.leading).font(.headline).padding().padding().overlay() {
                            
                            RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray).padding()
                            
                        }
                        
                        SecureField(LocalizedStringKey("4"), text: $passwordTextField).tint(.primary).autocorrectionDisabled(true).multilineTextAlignment(.leading).font(.headline).padding().padding().overlay() {
                            
                            RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray).padding()
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    Button {
                        
                        showingMainTabView = true
                        loggedIn = true
                        
                    } label: {
                        
                        RoundedRectangle(cornerRadius: 16).foregroundColor(.blue).overlay {
                            Text(LocalizedStringKey("5")).font(.headline).fontWeight(.bold).foregroundColor(.white)
                        }.frame(width: UIScreen.main.bounds.width - 40, height: currentWindow.screen.scale + 60, alignment: .center)
                        
                        
                        
                        
                    }.fullScreenCover(isPresented: $showingMainTabView) {
                        
                        MainTabView()
                        
                    }
                    
                    NavigationLink(destination: SignUpView()) {
                        
                        Text(LocalizedStringKey("6")).font(.headline).fontWeight(.bold).foregroundColor(.blue)
                        
                    }
                    
                }.padding(.bottom, 10)
                
            }.navigationTitle(Text(LocalizedStringKey("7")))
            
        }
        
    }
    
}

struct LoginInSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LoginInView()
    }
}
