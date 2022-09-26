//
//  SigninView.swift
//  SaudiMarch
//
//  Created by MacBook pro on 20/09/2022.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.slide
    }
}

struct SigninView: View {
    
    @State var mobileNumber: String = ""
    @State var password: String = ""
    
    @ObservedObject var vm: SigninViewModel = SigninViewModel()
        
    var body: some View {
        switch vm.state {
        case .success:
            HomeView()
        case .loading:
            Text("Loading")
        case .failure(let error):
            Text(error)
        case .ideal:
            bodyView
        }
    }
    
    var bodyView: some View {
        GeometryReader { metrics in
            ScrollView {
                
                Image("logo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 100)
                
                VStack {
                    Text("Welcome")
                    Text("Enter your data")
                        .padding(.top, 20)
                    TextField("Mobile", text: $mobileNumber)
                        .frame(height: 45)
                        .padding()
                        .keyboardType(.phonePad)
                    SecureField("Pasword", text: $password)
                        .keyboardType(.alphabet)
                        .frame(height: 45)
                        .padding()
                    
                    Button {
                        
                    } label: {
                        Text(vm.state == .loading ? "Forget password" : "fgfgffff")
                            .foregroundColor(.red)
                    }.padding(.bottom, 20)
                }
                .background(.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.clear, lineWidth: 5)
                        .frame(width: metrics.size.width - 25)
                )
                .frame(width: metrics.size.width - 20)
                .padding(.top, 0)
                
                AppButton(text: "Signin", width: metrics.size.width - 50, height: 45, backgroundColor: .green, cornerRadius: 20) {
                    Task {
                        await vm.login(phone: mobileNumber, password: password)
                        
                    }
                }.padding(.bottom, 30)
                
                HStack {
                    Text("Don't have Account?")
                    Button {
                        
                    } label: {
                        Text("Create account")
                    }
                    
                }
                
            }
            .frame(width: metrics.size.width)
            .background(self.vm.state.isLoading ? .red : .green)
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}

//extension View {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape( RoundedCorner(radius: radius, corners: corners) )
//    }
//}
//
//struct RoundedCorner: Shape {
//    
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//    
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}
