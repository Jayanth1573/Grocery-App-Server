//
//  File.swift
//  
//
//  Created by Jayanth Ambaldhage on 15/06/24.
//

import Foundation
import Vapor

struct LoginResponseDTO: Content {
    let error: Bool
    var reason: String? = nil
    let token: String?
    let userId: UUID
}
