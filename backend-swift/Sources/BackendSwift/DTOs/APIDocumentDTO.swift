import Fluent
import Vapor

struct APIDocumentDTO: Content {
    var id: UUID?
    var filename: String?
    var filetype: String?
    var slug: String?
    var uploadedAt: Date?

    func toModel() -> APIDocument {
        APIDocument(
            id: self.id,
            filename: self.filename ?? "",
            filetype: self.filetype ?? "",
            slug: self.slug ?? "",
            uploadedAt: self.uploadedAt ?? Date()
        )
    }
}
