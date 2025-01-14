//
//  Tabs.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

enum Tabs: Int, Identifiable, Hashable {
    case randomCatFact, cats, saved
    
    var id: Self { self }
}
