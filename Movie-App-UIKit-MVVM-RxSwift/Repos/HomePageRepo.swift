//
//  MovieRepo.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import Moya
import RxSwift
import Foundation


enum HomeService {
    case fetchMovies
    case searchMovies(query: String)
}

extension HomeService: TargetType {
    var baseURL: URL {
        return URL(string: EndPoints.moviesBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .fetchMovies: return EndPoints.fetchPopularMoviesEndpoint
        case .searchMovies(let query): return EndPoints.searchMoviesEndpoint.replacingOccurrences(of: " ", with: "%20").replacingOccurrences(of: "{query}", with: query)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMovies, .searchMovies(query: _) : return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchMovies, .searchMovies(query: _) : return .requestParameters(parameters: ["api_key": EndPoints.moviesApiKey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}


class HomePageRepo {
    
    let homeProvider = MoyaProvider<HomeService>()
    
    static let shared: HomePageRepo = HomePageRepo()
    
    func createRequest<T: Codable>(homeCase: HomeService) -> Observable<T> {
        
        let observable = Observable<T>.create { [self] observer -> Disposable in
            homeProvider.request(homeCase) { result in
                
                switch result {
                case .success(let response):
                    do {
                        let movies = try JSONDecoder().decode(T.self, from: response.data)
                        print(movies)
                        observer.onNext(movies)
                    } catch { observer.onError(error) }
                case .failure(let error): observer.onError(error)
                }
            }
            
            return Disposables.create()
        }.observe(on: MainScheduler.instance)
        
        return observable
    }
    
    func fetchMovies() -> Observable<Movies> { return createRequest(homeCase: .fetchMovies) }
    func searchMovies(query: String) -> Observable<Movies> { return createRequest(homeCase: .searchMovies(query: query)) }
    
}
