//
//  HomePageViewModel.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import SwiftUI
import Observation

@Observable
class HomePageViewModel {
    var selectedTab = Tabs.randomCatFact
    
    init() {
        
    }
}
