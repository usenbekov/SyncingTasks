//
//  SyncingTasksApp.swift
//  SyncingTasks
//
//  Created by Altynbek Usenbekov on 5/1/21.
//

import SwiftUI

@main
struct SyncingTasksApp: App {
    let service = MoviesWithDispatch()
//    let service = MoviesWithRxswift()
//    let service = MoviesWithCombine()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(service: service))
        }
    }
}
