//
//  CatsPageViewModel.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI
import Observation

@MainActor
@Observable
class CatsPageViewModel {
    private let catFactsService: CatFactsService
    
    var catBreeds: [CatBreed] = []
    var selectedCatBreed: CatBreed?
    var selectedCatFact: CatFactDTO?
    
    init(catFactsService: CatFactsService) {
        self.catFactsService = catFactsService
    }
    
    func onAppear() async {
        loadLocalData()
    }
    
    func loadLocalData() {
        if !catBreeds.isEmpty { return }
        
        if let url = Bundle.main.url(forResource: "CatBreeds", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode([CatBreed].self, from: data)
                self.catBreeds.append(contentsOf: jsonData)
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func selectCatBreed(_ catBreed: CatBreed) async {
        do {
            guard let catImage = try await catFactsService.getDefinedCatImage("https://api.thecatapi.com/v1/images/search?breed_ids=\(catBreed.id)") else { return }
            selectedCatBreed = catBreed
            selectedCatFact = CatFactDTO(catBreed, catImage)
        } catch {
            fatalError("Error in selecting a cat breed! \(error.localizedDescription)")
        }
    }
}
