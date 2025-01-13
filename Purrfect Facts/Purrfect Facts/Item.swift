//
//  Item.swift
//  Purrfect Facts
//
//  Created by Echo Lumaque on 1/14/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
