//
//  HomePage.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject private var catFactsService: CatFactsService
    @State private var vm: HomePageViewModel
    
    init() {
        _vm = State(wrappedValue:  HomePageViewModel())
    }
    
    var body: some View {
        TabView(selection: $vm.selectedTab) {
            Tab("Cat Fact", systemImage: "pawprint.fill", value: .randomCatFact) {
                RandomCatFactsPage(catFactsService: catFactsService, catFact: nil)
            }
            
            Tab("Cats", systemImage: "list.bullet", value: .cats) {
                CatsPage(catFactsService: catFactsService)
            }
            
            Tab("Saved", systemImage: "bookmark.fill", value: .saved) {
                SavedPage(catFactsService: catFactsService)
            }
        }
    }
}

#Preview {
    HomePage()
}
