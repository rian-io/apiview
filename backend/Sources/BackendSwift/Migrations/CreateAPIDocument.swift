import Fluent

struct CreateAPIDocument: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("api_documents")
            .id()
            .field("filename", .string, .required)
            .field("filetype", .string, .required)
            .field("slug", .string, .required)
            .unique(on: "slug")
            .field("uploaded_at", .datetime, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("api_documents").delete()
    }
}
