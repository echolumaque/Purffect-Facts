//
//  SavedPageViewModel.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI
import Observation

@MainActor
@Observable
class SavedPageViewModel {
    private let catFactsService: CatFactsService
    
    var savedCatFacts: [CatFactDTO] = []
    var selectedCatFact: CatFactDTO?
    
    init(catFactsService: CatFactsService) {
        self.catFactsService = catFactsService
    }
    
    func onAppear() async {
        let savedCatFacts = await catFactsService.getSavedFacts()
        if !self.savedCatFacts.isEmpty { self.savedCatFacts.removeAll() }
        self.savedCatFacts.append(contentsOf: savedCatFacts)
    }
    
    func selectCatFact(_ catFact: CatFactDTO) {
        selectedCatFact = catFact
    }
}
