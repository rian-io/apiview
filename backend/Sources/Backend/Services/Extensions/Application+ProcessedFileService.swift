import Vapor

extension Application {
    struct ProcessedFileServiceKey: StorageKey {
        typealias Value = ProcessedFileService
    }
    var processedFileService: ProcessedFileService {
        get {
            self.storage[ProcessedFileServiceKey.self]!
        }
        set {
            self.storage[ProcessedFileServiceKey.self] = newValue
        }
    }
}
