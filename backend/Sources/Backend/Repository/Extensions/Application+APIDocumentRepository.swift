import Vapor

extension Application {
    struct APIDocumentRepositoryKey: StorageKey {
        typealias Value = APIDocumentRepository
    }
    var apiDocumentRepository: APIDocumentRepository {
        get { self.storage[APIDocumentRepositoryKey.self]! }
        set { self.storage[APIDocumentRepositoryKey.self] = newValue }
    }
}
