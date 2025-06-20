import Vapor
import Yams

struct UploadService {
    static func processUpload(file: File, filename: String, ext: String, slug: String, req: Request)
        async throws -> ProcessedFileData
    {
        let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
        let savePath = uploadsDirectory + slug + "." + ext

        try saveFile(file, to: savePath)
        try await saveDocument(filename: filename, filetype: ext, slug: slug, req: req)

        let extracted = try OpenAPIService.extractInfoAndEndpoints(from: savePath)
        return ProcessedFileData(
            info: extracted["info"] as? ApiInfo ?? ApiInfo(title: "Unknown", version: "1.0"),
            endpoints: extracted["endpoints"] as? [Endpoint] ?? [],
            filename: filename,
            message: "OK"
        )
    }

    private static func saveFile(_ file: File, to path: String) throws {
        let directory = (path as NSString).deletingLastPathComponent
        try FileManager.default.createDirectory(
            atPath: directory, withIntermediateDirectories: true)
        let data = Data(buffer: file.data)
        try data.write(to: URL(fileURLWithPath: path))
    }

    private static func saveDocument(filename: String, filetype: String, slug: String, req: Request)
        async throws
    {
        let doc = APIDocument(
            filename: filename, filetype: filetype, slug: slug, uploadedAt: Date())
        try await doc.save(on: req.db)
    }
}
