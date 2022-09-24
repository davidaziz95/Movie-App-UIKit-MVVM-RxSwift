//
//  MovieModel.swift
//  Movie-App-SwiftUI-MVI
//
//  Created by David Aziz [Pharma] on 03/09/2022.
//

import Foundation


struct Movies: Codable {
    var results: [Movie]
}

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var overview: String
    var poster_path: String? = nil
}
