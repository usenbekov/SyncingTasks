//
//  ContentView.swift
//  SyncingTasks
//
//  Created by Altynbek Usenbekov on 5/1/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.loading {
                    ProgressView("Loading")
                } else {
                    List(viewModel.movies, id: \.id) { movie in
                        HStack {
                            Text(movie.title)
                            Spacer()
                            Text("$\(movie.price)")
                        }
                        .padding()
                    }
                }
            }
            .onAppear(perform: {
                viewModel.getMovies()
            })
            .navigationBarTitle("Movies")
            .navigationBarItems(
                trailing: Button("Load Movies") {
                    viewModel.getMovies()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(service: MoviesWithDispatch()))
    }
}
