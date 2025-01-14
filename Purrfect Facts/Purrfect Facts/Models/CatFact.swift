//
//  CatFact.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import Foundation
import SwiftData

@Model
class CatFact {
    var adaptability: Int?
    var affectionLevel: Int?
    var catFactId: String
    var childFriendly: Int?
    var dogFriendly: Int?
    var energyLevel: Int?
    var facts: [String]
    var grooming: Int?
    var healthIssues: Int?
    var indoor: Int?
    var intelligence: Int?
    var isHairless: Bool?
    var lifeSpan: String?
    var name: String?
    var isRare: Bool?
    var sheddingLevel: Int?
    var socialNeeds: Int?
    var strangerFriendly: Int?
    var temperament: String?
    var url: String
    var vocalisation: Int?
    var height: Double
    var width: Double
    
    init(
        adaptability: Int?,
        affectionLevel: Int?,
        catFactId: String,
        childFriendly: Int?,
        dogFriendly: Int?,
        energyLevel: Int?,
        facts: [String],
        grooming: Int?,
        healthIssues: Int?,
        indoor: Int?,
        intelligence: Int?,
        isHairless: Bool?,
        lifeSpan: String?,
        name: String?,
        isRare: Bool?,
        sheddingLevel: Int?,
        socialNeeds: Int?,
        strangerFriendly: Int?,
        temperament: String?,
        url: String,
        vocalisation: Int?,
        height: Double,
        width: Double
    ) {
        self.adaptability = adaptability
        self.affectionLevel = affectionLevel
        self.catFactId = catFactId
        self.childFriendly = childFriendly
        self.dogFriendly = dogFriendly
        self.energyLevel = energyLevel
        self.facts = facts
        self.grooming = grooming
        self.healthIssues = healthIssues
        self.indoor = indoor
        self.intelligence = intelligence
        self.isHairless = isHairless
        self.lifeSpan = lifeSpan
        self.name = name
        self.isRare = isRare
        self.sheddingLevel = sheddingLevel
        self.socialNeeds = socialNeeds
        self.strangerFriendly = strangerFriendly
        self.temperament = temperament
        self.url = url
        self.vocalisation = vocalisation
        self.height = height
        self.width = width
    }
}

struct CatImageDTO: Decodable {
    var id: String = ""
    var url: String = ""
    var height: Double = 0
    var width: Double = 0
}

struct CatFactDataDTO: Identifiable, Codable {
    var id: UUID = UUID()
    var data: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}


struct CatFactDTO: SendableModel {
    var adaptability: Int?
    var affectionLevel: Int?
    var childFriendly: Int?
    var dogFriendly: Int?
    var energyLevel: Int?
    var facts: [String] = []
    var grooming: Int?
    var healthIssues: Int?
    var id: String = ""
    var indoor: Int?
    var intelligence: Int?
    var isHairless: Bool?
    var lifeSpan: String?
    var name: String = ""
    var isRare: Bool?
    var sheddingLevel: Int?
    var socialNeeds: Int?
    var strangerFriendly: Int?
    var temperament: String?
    var url: String = ""
    var vocalisation: Int?
    var height: Double = 0
    var width: Double = 0
    var persistentId: PersistentIdentifier?
    
    init() { }
    
    init(image: CatImageDTO, facts: CatFactDataDTO) {
        self.id = image.id
        self.facts = facts.data
        self.url = image.url
        self.height = image.height
        self.width = image.width
    }
    
    init(_ catBreed: CatBreed, _ image: CatImageDTO) {
        self.adaptability = catBreed.adaptability
        self.affectionLevel = catBreed.affectionLevel
        self.childFriendly = catBreed.childFriendly
        self.dogFriendly = catBreed.dogFriendly
        self.energyLevel = catBreed.energyLevel
        self.facts = [catBreed.catDescription]
        self.grooming = catBreed.grooming
        self.healthIssues = catBreed.healthIssues
        self.id = catBreed.id
        self.indoor = catBreed.indoor
        self.intelligence = catBreed.intelligence
        self.isHairless = catBreed.hairless == 1
        self.lifeSpan = catBreed.lifeSpan
        self.isRare = catBreed.rare == 1
        self.name = catBreed.name
        self.sheddingLevel = catBreed.sheddingLevel
        self.socialNeeds = catBreed.socialNeeds
        self.strangerFriendly = catBreed.strangerFriendly
        self.temperament = catBreed.temperament
        self.url = image.url
        self.vocalisation = catBreed.vocalisation
        self.height = image.height
        self.width = image.width
    }
    
    init(_ entity: CatFact?) {
        self.adaptability = entity?.adaptability ?? .zero
        self.affectionLevel = entity?.affectionLevel ?? .zero
        self.childFriendly = entity?.childFriendly ?? .zero
        self.dogFriendly = entity?.dogFriendly ?? .zero
        self.energyLevel = entity?.energyLevel ?? .zero
        self.facts = entity?.facts ?? []
        self.grooming = entity?.grooming ?? .zero
        self.healthIssues = entity?.healthIssues ?? .zero
        self.id = entity?.catFactId ?? ""
        self.indoor = entity?.indoor ?? .zero
        self.intelligence = entity?.intelligence ?? .zero
        self.isHairless = entity?.isHairless
        self.lifeSpan = entity?.lifeSpan ?? ""
        self.isRare = entity?.isRare
        self.name = entity?.name ?? ""
        self.sheddingLevel = entity?.sheddingLevel ?? .zero
        self.socialNeeds = entity?.socialNeeds ?? .zero
        self.strangerFriendly = entity?.strangerFriendly ?? .zero
        self.temperament = entity?.temperament ?? ""
        self.url = entity?.url ?? ""
        self.vocalisation = entity?.vocalisation ?? .zero
        self.height = entity?.height ?? .zero
        self.width = entity?.width ?? .zero
    }
    
    static func == (lhs: CatFactDTO, rhs: CatFactDTO) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
