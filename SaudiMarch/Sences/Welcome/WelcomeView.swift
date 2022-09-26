//
//  ContentView.swift
//  SaudiMarch
//
//  Created by MacBook pro on 19/09/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var isSigninViewPresented: Bool = false
    
    var body: some View {
        GeometryReader { metrics in
            ScrollView {
                VStack(alignment: .center) {
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 400)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 10)
                    
                    Text("Welcome")
                        .bold()
                        .padding(.bottom, 1)
                    
                    
                    AppButton(text: "Create account", width: metrics.size.width - 40, height: 45, backgroundColor: .green, textColor: .white, cornerRadius: 18, borderColor: .yellow, borderWidth: 3) {
                        self.isSigninViewPresented.toggle()
                    }
                    
                    HStack {
                        Text("Have Account?")
                        Button {
                            
                        } label: {
                            Text("Login")
                        }
                        
                    }
                    
                    
                }
            }
            .frame(width: metrics.size.width)
            .background(.white)
            .fullScreenCover(isPresented: $isSigninViewPresented) {
                SigninView()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

