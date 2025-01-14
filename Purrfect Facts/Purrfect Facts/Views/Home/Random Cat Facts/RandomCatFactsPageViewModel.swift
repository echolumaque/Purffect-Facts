//
//  RandomCatFactsPageViewModel.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI
import Observation

@MainActor
@Observable
class RandomCatFactsPageViewModel {
    private let catFactsService: CatFactsService
    
    var catBreed: CatBreed?
    var catFact: CatFactDTO?
    var canGenerateFactsOnTap: Bool
    var isSaved = false
    var pageTitle: String
    
    init(catBreed: CatBreed? = nil,
         canGenerateFactsOnTap: Bool,
         catFactsService: CatFactsService,
         catFact: CatFactDTO? = nil,
         pageTitle: String) {
        self.catBreed = catBreed
        self.canGenerateFactsOnTap = canGenerateFactsOnTap
        self.catFactsService = catFactsService
        self.catFact = catFact
        self.pageTitle = pageTitle
    }
    
    func onAppear() async {
        if catFact == nil {  await getRandomCatFact() }
        
        guard let id = catFact?.id else { return }
        isSaved = await catFactsService.isASavedFact(id)
    }
    
    func getRandomCatFact() async {
        do {
            catFact = try await catFactsService.getRandomFact()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveRandomCatFact() async {
        guard let catFact else { return }
        do {
            try await catFactsService.saveOrDeleteCatFact(catFact: catFact, catBreed: catBreed)
            isSaved.toggle()
        } catch {
            
        }
    }
}
