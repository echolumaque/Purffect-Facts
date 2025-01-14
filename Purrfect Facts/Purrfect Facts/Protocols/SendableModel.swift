//
//  SendableModel.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import Foundation
import SwiftData

protocol SendableModel: Sendable, Identifiable, Equatable, Hashable {
    associatedtype Entity: PersistentModel
    var persistentId: PersistentIdentifier? { get }
    
    init(_ entity: Entity?)
}
