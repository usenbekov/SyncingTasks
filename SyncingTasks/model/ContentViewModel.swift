//
//  ContentViewModel.swift
//  SyncingTasks
//
//  Created by Altynbek Usenbekov on 5/1/21.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let price: Int
}

class ContentViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var loading = false
    let service: MoviesService
    
    init(service: MoviesService) {
        self.service = service
    }
    
    func getMovies() {
        let started = Date()
        
        loading = true;
        self.service.getMovies(with: [0, 1, 2, 3, 4]) { [weak self] movies in
            self?.loading = false
            self?.movies = movies
            
            print("Loaded in \(String(format:"%.02f", started.distance(to: Date()))) sec.")
        }
    }
}

protocol MoviesService {
    func getMovies(with ids: [Int], completion: @escaping ([Movie]) -> Void)
}

extension MoviesService {
    func sampleMovie(with id: Int) -> Movie {
        var movie: Movie
        switch id {
        case 0:
            movie = Movie(id: id, title: "Tenet", price: 20)
        case 1:
            movie = Movie(id: id, title: "Interstellar", price: 21)
        case 2:
            movie = Movie(id: id, title: "Inception", price: 22)
        case 3:
            movie = Movie(id: id, title: "The Dark Knight", price: 23)
        default:
            movie = Movie(id: id, title: "Dunkirk", price: 24)
        }
        return movie
    }
}
