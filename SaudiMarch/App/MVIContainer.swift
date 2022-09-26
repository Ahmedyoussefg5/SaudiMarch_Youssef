//
//  MVIContainer.swift
//  SaudiMarch
//
//  Created by MacBook pro on 20/09/2022.
//

import Foundation
import SwiftUI
import Combine

typealias AppSubject<T> = PassthroughSubject<ScreenState<T>, Never>
typealias AppBag = Set<AnyCancellable>

class MVIContainer<Intent, Model>: ObservableObject {

    // MARK: Public

    let intent: Intent
    let model: Model

    // MARK: private

    private var cancellable: Set<AnyCancellable> = []

    // MARK: Life cycle

    init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model

        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}
