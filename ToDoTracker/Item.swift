//
//  Item.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/3/26.
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
