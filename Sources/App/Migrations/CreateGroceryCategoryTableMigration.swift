//
//  File.swift
//  
//
//  Created by Jayanth Ambaldhage on 26/06/24.
//

import Foundation
import Fluent

struct CreateGroceryCategoryTableMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("grocery_categories")
            .id()
            .field("title", .string, .required)
            .field("color_code", .string, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("grocery_categories")
            .delete()
    }
    
  
    
    
}
