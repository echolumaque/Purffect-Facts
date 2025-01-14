//
//  SwiftDataManager.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import Foundation
import SwiftData

class SwiftDataManager {
    static let modelContainer: ModelContainer = {
        do {
            let localConfiguration = ModelConfiguration("localConfig",
                                                        isStoredInMemoryOnly: false,
                                                        cloudKitDatabase: .none)
            let modelContainer = try ModelContainer(for: CatFact.self, configurations: localConfiguration)
            
            return modelContainer
        } catch {
            fatalError("Error in initializing model container! \(error.localizedDescription)")
        }
    }()
}
