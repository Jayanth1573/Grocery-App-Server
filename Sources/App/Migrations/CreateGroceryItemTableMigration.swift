//
//  File.swift
//  
//
//  Created by Jayanth Ambaldhage on 02/07/24.
//

import Foundation
import Fluent

struct CreateGroceryItemTableMigration: AsyncMigration {
   
    
    func prepare(on database: Database) async throws {
        try await database.schema("grocery_items")
            .id()
            .field("title", .string, .required)
            .field("price", .double, .required)
            .field("quantity", .int, .required)
            .field("grocery_category_id", .uuid, .required, .references("grocery_categories", "id", onDelete: .cascade))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("grocery_items")
            .delete()
    }
}
