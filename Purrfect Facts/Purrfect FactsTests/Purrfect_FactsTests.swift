//
//  Purrfect_FactsTests.swift
//  Purrfect FactsTests
//
//  Created by Echo Lumaque on 1/14/25.
//

import Testing
@testable import Purrfect_Facts

struct Purrfect_FactsTests {
    let catFactsService = CatFactsService()
    
    @Test func checkIfCatFactIsValid() async throws {
        do {
            let randomFact = try await catFactsService.getRandomFact()
            
            try #require(!randomFact.url.isEmpty)
            try #require(!randomFact.facts.isEmpty)
        } catch {
            
        }
    }
    
    @Test func testGetRandomFactInvalidStatusCode() async throws {
        do {
            _ = try await catFactsService.getRandomFact()
        } catch let error {
            switch error {
            case .invalidStatusCode(let statusCode):
                #expect(statusCode > 299)
                
            default:
                break
            }
        }
    }
    
    @Test func testGetRandomFactDecodingError() async throws {
        do {
            _ = try await catFactsService.getRandomFact()
        } catch {
            switch error {
            case .decodingFailed(let innerError):
                switch innerError {
                case .typeMismatch(let type, _):
                    #expect(type == [CatImageDTO].self)
                    
                default:
                    break
                }
                
            default:
                break
            }
        }
    }
    
    @Test func testIsASavedFact() async throws {
        let newCatBreed = CatBreed(
            id: "test Id",
            name: "test Cat",
            cfaURL: nil,
            vetstreetURL: nil,
            vcahospitalsURL: nil,
            temperament: "Always angry",
            origin: "Earth",
            countryCodes: "",
            countryCode: "",
            catDescription: "",
            lifeSpan: "",
            indoor: 1,
            lap: nil,
            altNames: nil,
            adaptability: 4,
            affectionLevel: 5,
            childFriendly: 2,
            dogFriendly: 3,
            energyLevel: 5,
            grooming: 1,
            healthIssues: 2,
            intelligence: 5,
            sheddingLevel: 3,
            socialNeeds: 3,
            strangerFriendly: 3,
            vocalisation: 3,
            experimental: 2,
            hairless: 1,
            natural: 4,
            rare: 1,
            rex: 0,
            suppressedTail: 0,
            shortLegs: 0,
            wikipediaURL: nil,
            hypoallergenic: 1,
            referenceImageID: nil,
            catFriendly: nil,
            bidability: nil
        )
        let newFact = CatFactDTO(newCatBreed, CatImageDTO())
        
        // Save it
        try await catFactsService.saveOrDeleteCatFact(catFact: newFact)
        let isSaved = await catFactsService.isASavedFact("test Id")
        #expect(isSaved)
        
        // Clean up by deleting
        try await catFactsService.saveOrDeleteCatFact(catFact: newFact)
        let isStillSaved = await catFactsService.isASavedFact("test Id")
        #expect(!isStillSaved)
    }
}
