//
//  Purrfect_FactsApp.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI

@main
struct Purrfect_FactsApp: App {
    @StateObject private var catFactsService: CatFactsService
    
    init() {
        _catFactsService = StateObject(wrappedValue: CatFactsService(modelContainer: SwiftDataManager.modelContainer))
    }
    
    var body: some Scene {
        WindowGroup {
            HomePage()
                .environmentObject(catFactsService)
        }
    }
}
