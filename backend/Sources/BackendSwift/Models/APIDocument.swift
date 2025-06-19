import Fluent
import Foundation

import struct Foundation.UUID

final class APIDocument: Model, @unchecked Sendable {
    static let schema = "api_documents"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "filename")
    var filename: String

    @Field(key: "filetype")
    var filetype: String

    @Field(key: "slug")
    var slug: String

    @Field(key: "uploaded_at")
    var uploadedAt: Date

    init() {}

    init(id: UUID? = nil, filename: String, filetype: String, slug: String, uploadedAt: Date) {
        self.id = id
        self.filename = filename
        self.filetype = filetype
        self.slug = slug
        self.uploadedAt = uploadedAt
    }

    func toDTO() -> APIDocumentDTO {
        .init(
            id: self.id,
            filename: self.filename,
            filetype: self.filetype,
            slug: self.slug,
            uploadedAt: self.uploadedAt
        )
    }
}
