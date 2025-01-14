//
//  SavedPage.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI

struct SavedPage: View {
    @EnvironmentObject private var catFactsService: CatFactsService
    @State private var vm: SavedPageViewModel
    
    init(catFactsService: CatFactsService) {
        _vm = State(wrappedValue:  SavedPageViewModel(catFactsService: catFactsService))
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.savedCatFacts.isEmpty {
                    ContentUnavailableView("No saved facts!", systemImage: "circle.slash", description: Text("It seems your saved cat facts are empty."))
                } else {
                    List {
                        ForEach(Array(vm.savedCatFacts.enumerated()), id: \.offset) { (index, catFact) in
                            DisclosureGroup {
                                Text(catFact.facts.first ?? "")
                                    .contentShape(.rect)
                                    .onTapGesture { vm.selectedCatFact = catFact }
                            } label: {
                                AsyncImage(url: URL(string: catFact.url)) { image in
                                    HStack {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        
                                        Text("Fact #\(index + 1)")
                                    }
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                    .sheet(
                        item: $vm.selectedCatFact,
                        onDismiss: {
                            Task { await vm.onAppear() }
                        },
                        content: { selectedCatFact in
                            let catBreed = CatBreed(
                                id: selectedCatFact.id,
                                name: selectedCatFact.name,
                                cfaURL: nil,
                                vetstreetURL: nil,
                                vcahospitalsURL: nil,
                                temperament: selectedCatFact.temperament ?? "",
                                origin: "",
                                countryCodes: "",
                                countryCode: "",
                                catDescription: selectedCatFact.facts.first ?? "",
                                lifeSpan: selectedCatFact.lifeSpan ?? "",
                                indoor: selectedCatFact.indoor ?? .zero,
                                lap: 0,
                                altNames: "",
                                adaptability: selectedCatFact.adaptability ?? .zero,
                                affectionLevel: selectedCatFact.affectionLevel ?? .zero,
                                childFriendly: selectedCatFact.childFriendly ?? .zero,
                                dogFriendly: selectedCatFact.dogFriendly ?? .zero,
                                energyLevel: selectedCatFact.energyLevel ?? .zero,
                                grooming: selectedCatFact.grooming ?? .zero,
                                healthIssues: selectedCatFact.healthIssues ?? .zero,
                                intelligence: selectedCatFact.intelligence ?? .zero,
                                sheddingLevel: selectedCatFact.sheddingLevel ?? .zero,
                                socialNeeds: selectedCatFact.socialNeeds ?? .zero,
                                strangerFriendly: selectedCatFact.strangerFriendly ?? .zero,
                                vocalisation: selectedCatFact.vocalisation ?? .zero,
                                experimental: 0,
                                hairless: (selectedCatFact.isHairless ?? false) ? 1 : 0,
                                natural: 0,
                                rare: (selectedCatFact.isRare ?? false) ? 1 : 0,
                                rex: 0,
                                suppressedTail: 0,
                                shortLegs: 0,
                                wikipediaURL: "",
                                hypoallergenic: 0,
                                referenceImageID: "",
                                catFriendly: 0,
                                bidability: 0
                            )
                            
                            RandomCatFactsPage(catBreed: catBreed,
                                               canGenerateFactsOnTap: false,
                                               catFactsService: catFactsService,
                                               catFact: selectedCatFact,
                                               pageTitle: catBreed.name.isEmpty ? "Random Cat Fact" : catBreed.name)
                    })
                }
            }
            .task {
                await vm.onAppear()
            }
            .navigationTitle("Saved Facts")
        }
    }
}

#Preview {
    SavedPage(catFactsService: CatFactsService())
}
