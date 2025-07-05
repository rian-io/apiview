import Vapor

extension Application {
    struct UploadServiceKey: StorageKey {
        typealias Value = UploadService
    }
    var uploadService: UploadService {
        get { self.storage[UploadServiceKey.self]! }
        set { self.storage[UploadServiceKey.self] = newValue }
    }
}
