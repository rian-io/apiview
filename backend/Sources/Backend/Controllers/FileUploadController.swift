import Vapor
import Yams

struct FileUploadController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let fileUpload = routes.grouped("upload")
        fileUpload.post(use: self.upload)
    }

    @Sendable
    func upload(req: Request) async throws -> String {
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
        let success = try await UploadService.processUpload(
            file: file, filename: filename, ext: ext, slug: slug, req: req)

        if success {
            return slug
        } else {
            throw Abort(.internalServerError, reason: "File upload failed.")
        }
    }
}
