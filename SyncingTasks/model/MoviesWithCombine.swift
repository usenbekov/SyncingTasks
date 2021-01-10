//
//  MoviesWithCombine.swift
//  SyncingTasks
//
//  Created by Altynbek Usenbekov on 5/1/21.
//

import Foundation
import Combine

class MoviesWithCombine: MoviesService {
    var cancellable: AnyCancellable?
    
    func getMovies(with ids: [Int], completion: @escaping ([Movie]) -> Void) {
        cancellable = ids.map{ getMovie(with: $0).eraseToAnyPublisher() }
            .publisher
            .flatMap { $0 }
            .collect()
            .sink { movies in
                completion(movies.sorted(by: { $0.id < $1.id }))
            }
    }
    
    func getMovie(with id: Int) -> AnyPublisher<Movie, Never> {
        let pass = PassthroughSubject<Movie, Never>()
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.2...2)) {
            pass.send(self.sampleMovie(with: id))
            pass.send(completion: .finished)
        }
        return pass.eraseToAnyPublisher()
    }
}
