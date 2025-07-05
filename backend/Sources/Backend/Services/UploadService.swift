import Vapor
import Yams

struct UploadService {
    func processUpload(file: File, filename: String, ext: String, slug: String, req: Request)
        async throws -> Bool
    {
        let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
        let savePath = uploadsDirectory + slug + "." + ext

        try saveFile(file, to: savePath)
        try await saveDocument(filename: filename, filetype: ext, slug: slug, req: req)

        return true
    }

    private func saveFile(_ file: File, to path: String) throws {
        let directory = (path as NSString).deletingLastPathComponent
        try FileManager.default.createDirectory(
            atPath: directory, withIntermediateDirectories: true)
        let data = Data(buffer: file.data)
        try data.write(to: URL(fileURLWithPath: path))
    }

    private func saveDocument(filename: String, filetype: String, slug: String, req: Request)
        async throws
    {
        let doc = APIDocument(
            filename: filename, filetype: filetype, slug: slug, uploadedAt: Date())
        try await doc.save(on: req.db)
    }
}
