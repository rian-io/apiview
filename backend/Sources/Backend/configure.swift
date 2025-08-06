import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // Serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure the application to use SQLite
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    // Configure migrations
    app.migrations.add(CreateAPIDocument())

    // Configure the routes
    app.routes.defaultMaxBodySize = "100kb"

    // Registro dos serviços para injeção de dependência
    app.processedFileService = ProcessedFileService()
    app.openAPIService = OpenAPIService()
    app.uploadService = UploadService()

    // Registro do repositório para injeção de dependência
    app.apiDocumentRepository = APIDocumentRepository()

    // Register routes
    try routes(app)
}
