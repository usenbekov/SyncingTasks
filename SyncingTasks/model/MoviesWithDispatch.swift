//
//  MoviesWithDispatch.swift
//  SyncingTasks
//
//  Created by Altynbek Usenbekov on 5/1/21.
//

import Foundation

class MoviesWithDispatch: MoviesService {
    
    func getMovies(with ids: [Int], completion: @escaping ([Movie]) -> Void) {
        var byId = [Int: Movie]()
        let group = DispatchGroup()
        ids.forEach { id in
            group.enter()
            getMovie(with: id) { (movie, err) in
                byId[id] = movie
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(ids.map { byId[$0]! })
        }
    }
    
    func getMovie(with id: Int, completion: @escaping (Movie?, Error?) -> Void) {
        let started = Date();
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.2...2)) {
            let movie = self.sampleMovie(with: id)
            print("\(String(format:"%.02f", started.distance(to: Date()))) sec. -> \(movie)")
            completion(movie, nil);
        }
    }
}
