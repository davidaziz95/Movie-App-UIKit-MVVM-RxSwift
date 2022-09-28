//
//  HomePageViewModel.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import RxSwift
import RxCocoa
import Foundation

class HomePageViewModel {
    
    let repository: HomePageRepo
    let disposableBag = DisposeBag()
    var movies = BehaviorSubject(value: [Movie]())
    let isLoading = BehaviorRelay<Bool>(value: true)
    
    init(dataManager: HomePageRepo = HomePageRepo.shared) {
        self.repository = dataManager
        loadMovies()
    }
    
    func loadMovies() {
        isLoading.accept(true)
        repository
            .fetchMovies()
            .subscribe(
                onNext: { [weak self] response in
                    self?.isLoading.accept(false)
                    self?.movies.on(.next(response.results))
                },
                onError: { error in
                    debugPrint(error)
                }
            ).disposed(by: disposableBag)
        
    }
}
