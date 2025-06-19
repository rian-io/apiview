import Vapor
import Yams

struct FileUploadController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let fileUpload = routes.grouped("upload")
        fileUpload.post(use: self.upload)
    }

    @Sendable
    func upload(req: Request) async throws -> ProcessedFileData {
        // Ensure the request contains a file upload
        guard req.content.contentType == .formData else {
            throw Abort(.badRequest, reason: "Content type must be multipart/form-data")
        }

        guard let file = try? req.content.get(File.self, at: "file") else {
            throw Abort(.badRequest, reason: "No file uploaded.")
        }

        let filename = file.filename
        guard !filename.isEmpty else {
            throw Abort(.badRequest, reason: "No file provided.")
        }

        let ext = filename.split(separator: ".").last.map { String($0).lowercased() } ?? ""
        guard ["json", "yaml", "yml"].contains(ext) else {
            throw Abort(.badRequest, reason: "Only JSON or YAML files are accepted.")
        }

        let slug = String(UUID().uuidString.prefix(8))
        let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
        let savePath = uploadsDirectory + slug + "." + ext

        try saveFile(file, to: savePath)
        try await saveDocument(filename: filename, filetype: ext, slug: slug, req: req)
        let extracted = try extractInfoAndEndpoints(from: savePath)

        req.logger.info("File \(filename) uploaded and processed successfully.")

        req.logger.info("Info -- \(extracted["info"]!).")

        let apiInfo = extracted["info"] as? ApiInfo ?? ApiInfo(title: "Unknown", version: "1.0")

        req.logger.info(
            "Extracted data: \(apiInfo)."
        )

        return ProcessedFileData(
            info: extracted["info"] as? ApiInfo ?? ApiInfo(title: "Unknown", version: "1.0"),
            endpoints: extracted["endpoints"] as? [Endpoint] ?? [],
            filename: filename,
            message: "File uploaded and parsed successfully"
        )
    }

    private func saveFile(_ file: File, to path: String) throws {
        // Ensure directory exists
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

    private func extractInfoAndEndpoints(from filePath: String) throws -> [String: Any] {
        let url = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: url)
        let ext = url.pathExtension.lowercased()
        var spec: [String: Any] = [:]
        if ext == "json" {
            spec = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
        } else if ext == "yaml" || ext == "yml" {
            if let yamlString = String(data: data, encoding: .utf8) {
                spec = try Yams.load(yaml: yamlString) as? [String: Any] ?? [:]
            }
        }
        return OpenAPIService.extractEndpoints(from: spec)
    }
}
