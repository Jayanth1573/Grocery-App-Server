//
//  File.swift
//  
//
//  Created by Jayanth Ambaldhage on 04/07/24.
//

import Foundation
import Vapor

struct JSONWebTokenAuthenticator: AsyncRequestAuthenticator {
    func authenticate(request: Request) async throws {
        try request.jwt.verify(as: AuthPayload.self)
    }
}
