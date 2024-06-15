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
        
        //   /api/login
        api.post("login", use: login)
    }
    
    func login(req: Request) async throws -> LoginResponseDTO {
        
        // decode the request
        let user = try req.content.decode(User.self)
        
        // check if the user exists in the database
        
        guard let existingUser = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() else {
            throw Abort(.badRequest)
        }
        
        // validate the password
        let result = try await req.password.async.verify(user.password, created: existingUser.password)
        
        if !result {
            throw Abort(.unauthorized)
        }
        
        // if result == true, generate the JWT token and return it to user
        let authPayload = try AuthPayload.Payload(subject: .init(value: "Grocery App"), expiration: .init(value: .distantFuture), userId: existingUser.requireID())
        return try LoginResponseDTO(error: false, token: req.jwt.sign(authPayload), userId: existingUser.requireID())
        
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
