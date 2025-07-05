import Vapor

extension Application {
    struct OpenAPIServiceKey: StorageKey {
        typealias Value = OpenAPIService
    }
    var openAPIService: OpenAPIService {
        get { self.storage[OpenAPIServiceKey.self]! }
        set { self.storage[OpenAPIServiceKey.self] = newValue }
    }
}
