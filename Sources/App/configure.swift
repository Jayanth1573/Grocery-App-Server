import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    app.databases.use(.postgres(hostname: "localhost", username: "postgres", password: "",database: "grocerydb"), as: .psql)
    
    
    // add migrations
    app.migrations.add(CreateUsersTableMigration())
    
    
    // register controller
    
    try app.register(collection: UserController())
    try routes(app)
}
