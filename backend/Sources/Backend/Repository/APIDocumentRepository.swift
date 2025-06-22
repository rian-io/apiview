import FluentKit
import Vapor

struct APIDocumentRepository {

    static func getAllAPIDocuments(db: any Database) async -> [APIDocument] {
        return try! await APIDocument.query(on: db).all()
    }

    static func getAPIDocumentBySlug(_ slug: String, db: any Database) async throws -> APIDocument {
        guard
            let doc = try await APIDocument.query(on: db)
                .filter(\.$slug, .equal, slug)
                .first()
        else {
            throw Abort(.notFound, reason: "APIDocument with slug \(slug) not found")
        }
        return doc
    }

}
