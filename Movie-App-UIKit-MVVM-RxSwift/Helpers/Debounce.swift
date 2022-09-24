//
//  Debounce.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import Foundation


class DebouncedState<Value>: ObservableObject {
    @Published var currentValue: Value
    @Published var debouncedValue: Value
    
    init(initialValue: Value, delay: Double = 0.4) {
        _currentValue = Published(initialValue: initialValue)
        _debouncedValue = Published(initialValue: initialValue)
        $currentValue
            .debounce(for: .seconds(delay), scheduler: RunLoop.main)
            .assign(to: &$debouncedValue)
    }
}
