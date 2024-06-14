//
//  File.swift
//  
//
//  Created by Jayanth Ambaldhage on 14/06/24.
//

import Foundation
import Vapor
import Fluent

//  /api/register
//  /api/login
class UserController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        
        let api = routes.grouped("api")
        
        //   /api/register
        api.post("register", use: register)
    }
    
    func register(req: Request) async throws -> RegisterResponseDTO {
        // validate the user
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        // check whether username already exists
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "Username already taken.")
        }
        
        // if username is unique then hash the password
        
        user.password = try await req.password.async.hash(user.password)
        try await user.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
    }
    
}
