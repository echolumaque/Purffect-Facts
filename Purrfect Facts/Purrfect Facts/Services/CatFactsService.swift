//
//  CatFactsService.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import Foundation
import SwiftData

@ModelActor
actor CatFactsService: ObservableObject {
    init() {
        // For previews only
        let localConfiguration = ModelConfiguration("localConfig",
                                                    isStoredInMemoryOnly: true,
                                                    cloudKitDatabase: .none)
        
        self.init(modelContainer: try! ModelContainer(for: CatFact.self, configurations: localConfiguration))
    }
    
    func getRandomFact() async throws(NetworkingError) -> CatFactDTO {
        do {
            let catImageUrl = URL(string: "https://api.thecatapi.com/v1/images/search")!
            let catFactUrl =  URL(string: "https://meowfacts.herokuapp.com/")!
            async let catImg = try URLSession.shared.data(from: catImageUrl)
            async let catFact = try URLSession.shared.data(from: catFactUrl)
            
            let results: (
                image: (data: Data, response: URLResponse),
                fact: (data: Data, response: URLResponse)
            ) = await (
                try catImg,
                try catFact
            )
            
            let (imageData, factData): (Data, Data) = try {
                let (image, fact) = (results.image, results.fact)
                try [image, fact].forEach { result in
                    guard let statusCode = (result.response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                        throw NetworkingError.invalidStatusCode(statusCode: (result.response as? HTTPURLResponse)?.statusCode ?? -1)
                    }
                }
                
                return (image.data, fact.data)
            }()
            
            let parsedCatImage = try JSONDecoder().decode([CatImageDTO].self, from: imageData)
            let parsedCatFact = try JSONDecoder().decode(CatFactDataDTO.self, from: factData)
            let catFactDto = CatFactDTO(image: parsedCatImage.first ?? CatImageDTO(), facts: parsedCatFact)
            
            return catFactDto
        } catch let error as DecodingError {
            throw .decodingFailed(innerError: error)
        } catch let error as EncodingError {
            throw .encodingFailed(innerError: error)
        } catch let error as URLError {
            throw .requestFailed(innerError: error)
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw .otherError(innerError: error)
        }
    }
    
    func getDefinedCatImage(_ definedCatUrlString: String) async throws(NetworkingError) -> CatImageDTO? {
        do {
            let catFactUrl =  URL(string: definedCatUrlString)!
            let (data, response) = try await URLSession.shared.data(from: catFactUrl)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                throw NetworkingError.invalidStatusCode(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
            
            let parsedCatImage = try JSONDecoder().decode([CatImageDTO].self, from: data)
            return parsedCatImage.first
        } catch let error as DecodingError {
            throw .decodingFailed(innerError: error)
        } catch let error as EncodingError {
            throw .encodingFailed(innerError: error)
        } catch let error as URLError {
            throw .requestFailed(innerError: error)
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw .otherError(innerError: error)
        }
    }
    
    func getSavedFacts() -> [CatFactDTO] {
        do {
            let savedFacts = try modelContext.fetch(FetchDescriptor<CatFact>())
            let parsedFacts = savedFacts.map({ CatFactDTO($0) })
            
            return parsedFacts
        } catch {
            fatalError("Can't fetch saved cat facts! Error: \(error.localizedDescription)")
        }
    }
    
    func isASavedFact(_ id: String) -> Bool {
        do {
            let isSaved = try modelContext.fetchCount(FetchDescriptor<CatFact>(predicate: #Predicate { $0.catFactId == id })) > 0
            return isSaved
        } catch {
            fatalError("Can't fetch saved cat facts! Error: \(error.localizedDescription)")
        }
    }
    
    func saveOrDeleteCatFact(catFact: CatFactDTO, catBreed: CatBreed? = nil) throws {
        do {
            let catFactId = catFact.id
            let isExisting = try modelContext.fetchCount(FetchDescriptor<CatFact>(predicate: #Predicate { $0.catFactId == catFactId })) > 0
            
            if isExisting {
                try modelContext.delete(model: CatFact.self, where:  #Predicate { $0.catFactId == catFactId })
            } else {
                let newCatFact = CatFact(
                    adaptability: catBreed?.adaptability,
                    affectionLevel: catBreed?.affectionLevel,
                    catFactId: catFactId,
                    childFriendly: catBreed?.childFriendly,
                    dogFriendly: catBreed?.dogFriendly,
                    energyLevel: catBreed?.energyLevel,
                    facts: catFact.facts,
                    grooming: catBreed?.grooming,
                    healthIssues: catBreed?.healthIssues,
                    indoor: catBreed?.indoor,
                    intelligence: catBreed?.intelligence,
                    isHairless: catBreed?.hairless == 1,
                    lifeSpan: catBreed?.lifeSpan,
                    name: catBreed?.name,
                    isRare: catBreed?.rare == 1,
                    sheddingLevel: catBreed?.sheddingLevel,
                    socialNeeds: catBreed?.socialNeeds,
                    strangerFriendly: catBreed?.strangerFriendly,
                    temperament: catBreed?.temperament,
                    url: catFact.url,
                    vocalisation: catBreed?.vocalisation,
                    height: catFact.height,
                    width: catFact.width
                )
                
                modelContext.insert(newCatFact)
            }
            
            try modelContext.save()
        } catch {
            fatalError("Can't save a cat fact! Error: \(error.localizedDescription)")
        }
    }
}
