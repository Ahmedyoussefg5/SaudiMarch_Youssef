//
//  SigninViewModel.swift
//  SaudiMarch
//
//  Created by MacBook pro on 20/09/2022.
//

import Foundation
import Combine

struct LoginBody: JsonEncadable {
    let phone: String
    let password: String
}

class SigninViewModel: ObservableObject {
    
    @Published var state: ScreenState<EmptyData> = .ideal
    @Published var didLogin: Bool = false
    
    var bag = AppBag()
    
    @MainActor
    func login(phone: String, password: String) async {
//                state = .success(EmptyData())
        state = .loading
        let body = LoginBody(phone: phone, password: password)
        await AsyncRequest<EmptyData>(url: .path("login"), method: .get, body: body)
            .asPublisher()
            .sink {[weak self] value in
                if let data = value.data {
                    self?.saveUserData()
                    self?.state = .success(data)
                } else if let error = value.error {
                    self?.state = .failure(error.localizedDescription)
                }
            }.store(in: &bag)
    }
    
    private func saveUserData() {
        // save user Date
        didLogin = true
    }
    
}
