//
//  ProfileView.swift
//  HolaPost
//
//  Created by RMP on 17/10/1445 AH.
//

import SwiftUI

struct ProfileView: View {
    
    
    let currentWindow: UIWindow = UIWindow()
    
    @State private var showingFollowersSheet: Bool = false
    @State private var showingFollowingSheet: Bool = false
    @State private var showingSettingsView: Bool = false
    @State private var showingEditInformation: Bool = false
    @State private var showLoginPage: Bool = false
    
    
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                HStack {
                    
                    Image(systemName: "lock")
                    Button {
                        // ...
                    } label: {
                        
                        Text("Example").foregroundColor(.primary).font(.title).bold()
                        Image(systemName: "chevron.down").foregroundColor(.primary)
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        
                        showingSettingsView = true
                        
                    } label: {
                        
                        Image(systemName: "gearshape.fill").resizable().aspectRatio(contentMode: .fit).frame(width: currentWindow.frame.minX + 25, height: currentWindow.frame.minY + 25, alignment: .center).font(.title).foregroundColor(.primary)
                        
                    }.buttonStyle(.plain).fullScreenCover(isPresented: $showingSettingsView) {
                        
                        
                        Button {
                            
                            // Delete info from UserDefaults && AppStorage
                            UserDefaults.standard.removeObject(forKey: "In")
                            
                            showLoginPage = true
                            
                            
                        } label: {
                            
                            Text(LocalizedStringKey("23")).foregroundColor(.red).bold()
                            
                        }.fullScreenCover(isPresented: $showLoginPage) {
                            
                            LoginInView()
                            
                        }

                        
                    }



                }.padding()
                
                
                HStack {
                    
                    Button {
                        // ...
                    } label: {
                        
                        Circle().overlay {
                            
                            Image(systemName: "person.fill").resizable().frame(width: 130, height: 130, alignment: .center).foregroundColor(.white)
                            
                        }.foregroundColor(.gray).blendMode(.multiply).overlay {
                            
                            Image(systemName: "camera.fill").resizable().aspectRatio(contentMode: .fit).frame(width: currentWindow.screen.bounds.minX + 35, height: currentWindow.screen.bounds.minY + 25, alignment: .center).foregroundColor(.white)
                            
                        }.frame(width: currentWindow.screen.bounds.width / 4.2, height: currentWindow.screen.bounds.height / 6, alignment: .center)
                        
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        
                        
                        VStack {
                            
                            Text("0").bold()
                            Text("Posts").bold()
                            
                        }.font(.callout)
                        
                        Button {
                            
                            showingFollowersSheet = true
                            
                        } label: {
                            
                            VStack {
                                
                                Text("0").bold()
                                Text("followers").bold()
                                
                            }.font(.callout).foregroundColor(.primary)
                            
                        }.sheet(isPresented: $showingFollowersSheet) {
                            
                            
                            NothingHereView(nothingHereFrom: .constant("Followers"))
                            
                            
                        }

                        
                        
                        Button {
                            
                            showingFollowingSheet = true
                            
                        } label: {
                            
                            VStack {
                                
                                Text("0").bold()
                                Text("following").bold()
                                
                            }.font(.callout).foregroundColor(.primary)
                            
                        }.sheet(isPresented: $showingFollowingSheet) {
                            
                            NothingHereView(nothingHereFrom: .constant("Following"))
                            
                        }
                        
                        
                    }

                }.padding()
                
                
                VStack {
                    
                    Button {
                        
                        //showingEditInformation = true
                        
                    } label: {
                        
                        RoundedRectangle(cornerRadius: 10).frame(width: currentWindow.bounds.width - 40, height: currentWindow.bounds.midX / 2 - 50, alignment: .center).foregroundColor(.gray).opacity(0.25).overlay {
                            
                            Text(LocalizedStringKey("24")).foregroundColor(.primary).bold()
                            
                        }
                        
                    }.buttonStyle(.plain).fullScreenCover(isPresented: $showingEditInformation) {
                        
                        
                        
                        
                        
                    }
                    
                    Divider()
                    
                    VStack {
                        
                        Text(LocalizedStringKey("25")).font(.title3).bold()
                        
                    }.padding(.vertical, currentWindow.bounds.midX - 70).foregroundColor(.primary)
                   
                }
                
            }
            
        }
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
