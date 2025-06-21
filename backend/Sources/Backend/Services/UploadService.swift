import Vapor
import Yams

struct UploadService {
    static func processUpload(file: File, filename: String, ext: String, slug: String, req: Request)
        async throws -> Bool
    {
        let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
        let savePath = uploadsDirectory + slug + "." + ext

        try saveFile(file, to: savePath)
        try await saveDocument(filename: filename, filetype: ext, slug: slug, req: req)

        return true
    }

    static func getProcessedFileDataBySlug(_ slug: String, req: Request) async throws
        -> ProcessedFileData
    {
        guard
            let apiDocumentRecord = try? await APIDocument.query(on: req.db)
                .filter(\.$slug, .equal, slug)
                .first()
        else {
            throw Abort(.notFound, reason: "File not found")
        }

        let fileName = apiDocumentRecord.slug + "." + apiDocumentRecord.filetype
        let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
        let filePath = uploadsDirectory + fileName

        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Abort(.notFound, reason: "File \(fileName) not found")
        }

        let extracted = try OpenAPIService.extractInfoAndEndpoints(from: filePath)

        return ProcessedFileData(
            info: extracted["info"] as? ApiInfo ?? ApiInfo(title: "Unknown", version: "1.0"),
            endpoints: extracted["endpoints"] as? [Endpoint] ?? [],
            filename: fileName,
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
