//
//  File.swift
//  
//
//  Created by Jayanth Ambaldhage on 27/06/24.
//

import Foundation
import GroceryAppSharedDTO
import Vapor

extension GroceryCategoryResponseDTO: Content {
    
    init?(_ groceryCategory: GroceryCategory){
        guard let id = groceryCategory.id
        else {
            return nil
        }
        
        self.init(id: id, title: groceryCategory.title, colorCode: groceryCategory.colorCode)
                    
    }
    
}
