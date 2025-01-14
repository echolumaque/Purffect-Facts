//
//  CatBreed+Extension.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/15/25.
//

import Foundation

extension CatBreed {
    var traits: [String: Int] {
        [
            "Adaptability": self.adaptability,
            "Affection Level": self.affectionLevel,
            "Child Friendly": self.childFriendly,
            "Dog Friendly": self.dogFriendly,
            "Energy Level": self.energyLevel,
            "Grooming": self.grooming,
            "Health Issues": self.healthIssues,
            "Intelligence": self.intelligence,
            "Shedding Level": self.sheddingLevel,
            "Social Needs": self.socialNeeds,
            "Stranger Friendly": self.strangerFriendly,
            "Vocalisation": self.vocalisation,
        ]
    }
}
