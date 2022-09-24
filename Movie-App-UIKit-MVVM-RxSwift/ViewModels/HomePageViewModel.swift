//
//  HomePageViewModel.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import RxSwift
import Foundation

class HomePageViewModel: ObservableObject {
    
    let repository: HomePageRepo
    let disposableBag = DisposeBag()
    var movies = BehaviorSubject(value: [Movie]())
    @Published var searchQuery = DebouncedState(initialValue: "")
    
    
    init(dataManager: HomePageRepo = HomePageRepo.shared) {
        self.repository = dataManager
        loadMovies()
    }
    
    func loadMovies() {
        repository
            .fetchMovies()
            .subscribe(
                onNext: { [weak self] response in
                    self?.movies.on(.next(response.results))
                    // if response.results.isEmpty { self?.uiState = .NoResultsFound }
                    // else { self?.uiState = .Fetched(response) }
                },
                onError: { error in
                    debugPrint(error)
                }
            ).disposed(by: disposableBag)
    }
}
