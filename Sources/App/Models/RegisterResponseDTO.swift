//
//  File.swift
//  
//
//  Created by Jayanth Ambaldhage on 14/06/24.
//

import Foundation
import Vapor

struct RegisterResponseDTO: Content {
    let error: Bool
    var reason: String? = nil
}
