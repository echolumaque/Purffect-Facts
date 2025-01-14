//
//  RandomCatFactsPage.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI

struct RandomCatFactsPage: View {
    @State private var vm: RandomCatFactsPageViewModel
    
    init(catBreed: CatBreed? = nil,
         canGenerateFactsOnTap: Bool = true,
         catFactsService: CatFactsService,
         catFact: CatFactDTO?,
         pageTitle: String = "Random Cat Facts") {
        _vm = State(wrappedValue: RandomCatFactsPageViewModel(catBreed: catBreed,
                                                              canGenerateFactsOnTap: canGenerateFactsOnTap,
                                                              catFactsService: catFactsService,
                                                              catFact: catFact,
                                                              pageTitle: pageTitle))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let catFact = vm.catFact {
                    AsyncImage(url: URL(string: catFact.url)) { phase in
                        if let phase = phase.image {
                            List {
                                phase
                                    .resizable()
                                    .scaledToFit()
                                
                                Section {
                                    Text(catFact.facts.first ?? "")
                                        .font(.body)
                                } header: {
                                    Text("Random fact")
                                }
                                
                                if let catBreed = vm.catBreed, vm.pageTitle != "Random Cat Fact" {
                                    Section {
                                        HStack {
                                            Text("Average Lifespan")
                                            Spacer()
                                            Text("\(catBreed.lifeSpan) Years")
                                        }
                                        
                                        HStack {
                                            Text("Is indoor cat?")
                                            Spacer()
                                            Text(catBreed.indoor == 0 ? "No" : "Yes")
                                        }
                                        
                                        HStack {
                                            Text("Is hairless?")
                                            Spacer()
                                            Text(catBreed.hairless == 0 ? "No" : "Yes")
                                        }
                                        
                                        HStack {
                                            Text("Is rare?")
                                            Spacer()
                                            Text(catBreed.rare == 0 ? "No" : "Yes")
                                        }
                                        
                                        ForEach(catBreed.traits.sorted(by: { $0.key < $1.key }), id: \.key) { trait, value in
                                            HStack {
                                                Text(trait)
                                                Spacer()
                                                StarsView(rating: Double(value), maxRating: 5)
                                                    .frame(height: 16)
                                            }
                                        }
                                        
                                        HStack {
                                            Text("Temparament")
                                            Spacer()
                                            Text(catBreed.temperament)
                                        }
                                    } header: {
                                        Text("Breed traits")
                                    }
                                }
                            }
                        } else if phase.error != nil {
                            ContentUnavailableView("No fact available!", systemImage: "circle.slash", description: Text("It seems we can't a show a cat fact for you right now. Please try again later."))
                        } else {
                            ProgressView()
                        }
                    }
                    
                    Spacer()
                }
            }
            .task {
                await vm.onAppear()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        if vm.canGenerateFactsOnTap {
                            Button {
                                Task { await vm.getRandomCatFact() }
                            } label: {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                        
                        Button {
                            Task { await vm.saveRandomCatFact() }
                        } label: {
                            Image(systemName: vm.isSaved ? "bookmark.fill" : "bookmark")
                        }
                    }
                }
            }
            .navigationTitle(vm.pageTitle)
            .contentShape(.rect)
            .onTapGesture {
                if vm.canGenerateFactsOnTap {
                    Task { await vm.getRandomCatFact() }
                }
            }
        }
    }
}

#Preview {
    RandomCatFactsPage(catFactsService: CatFactsService(), catFact: nil)
        .environmentObject(CatFactsService())
}
