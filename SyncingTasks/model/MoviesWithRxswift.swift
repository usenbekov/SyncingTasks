//
//  MoviesWithRxswift.swift
//  SyncingTasks
//
//  Created by Altynbek Usenbekov on 6/1/21.
//

import Foundation
import RxSwift

class MoviesWithRxswift: MoviesService {
    let bag = DisposeBag()
    
    func getMovies(with ids: [Int], completion: @escaping ([Movie]) -> Void) {
        Observable.zip(ids.map{ getMovie(with: $0) })
            .subscribe { movies in
                completion(movies)
            }
            .disposed(by: bag)
    }
    
    func getMovie(with id: Int) -> Observable<Movie> {
        return Observable<Movie>.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.2...2)) {
                observer.onNext(self.sampleMovie(with: id))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}


