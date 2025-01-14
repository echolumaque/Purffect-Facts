//
//  CatsPage.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI

struct CatsPage: View {
    @EnvironmentObject private var catFactsService: CatFactsService
    @Environment(\.colorScheme) private var colorScheme
    @State private var vm: CatsPageViewModel
    
    init(catFactsService: CatFactsService) {
        _vm = State(wrappedValue:  CatsPageViewModel(catFactsService: catFactsService))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.catBreeds, id: \.id) { catBreed in
                    HStack {
                        Text(catBreed.name)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.footnote.bold())
                            .foregroundStyle(Color(hex: colorScheme == .light ? 0x95959A : 0x98979D))
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        Task { await vm.selectCatBreed(catBreed) }
                    }
                }
            }
            .task {
                await vm.onAppear()
            }
            .sheet(item: $vm.selectedCatFact) { catFact in
                RandomCatFactsPage(catBreed: vm.selectedCatBreed,
                                   canGenerateFactsOnTap: false,
                                   catFactsService: catFactsService,
                                   catFact: catFact,
                                   pageTitle: vm.selectedCatBreed?.name ?? "Cat")
            }
            .navigationTitle("Cats")
        }
    }
}

#Preview {
    CatsPage(catFactsService: CatFactsService())
}
