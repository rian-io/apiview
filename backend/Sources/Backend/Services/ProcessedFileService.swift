import Vapor

struct ProcessedFileService {
    static func getProcessedFileDataBySlug(_ slug: String, req: Request) async throws
        -> ProcessedFileData
    {
        let apiDocumentRecord = try! await APIDocumentRepository.getAPIDocumentBySlug(
            slug, db: req.db)

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

    static func getApiInfoBySlug(_ slug: String, req: Request) async throws -> ApiInfo {
        let apiDocumentRecord = try! await APIDocumentRepository.getAPIDocumentBySlug(
            slug, db: req.db)

        let fileName = apiDocumentRecord.slug + "." + apiDocumentRecord.filetype
        let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
        let filePath = uploadsDirectory + fileName

        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Abort(.notFound, reason: "File \(fileName) not found")
        }

        let extracted = try OpenAPIService.extractInfoAndEndpoints(from: filePath)

        return extracted["info"] as? ApiInfo ?? ApiInfo(title: "Unknown", version: "1.0")
    }

    static func getAllInfo(req: Request) async throws -> [ApiInfo] {
        let apiDocuments = await APIDocumentRepository.getAllAPIDocuments(db: req.db)

        guard !apiDocuments.isEmpty else {
            throw Abort(.notFound, reason: "No API documents found")
        }

        var apiInfos: [ApiInfo] = []

        for document in apiDocuments {
            let fileName = document.slug + "." + document.filetype
            let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
            let filePath = uploadsDirectory + fileName

            guard FileManager.default.fileExists(atPath: filePath) else {
                continue
            }

            let extracted = try OpenAPIService.extractInfoAndEndpoints(from: filePath)
            if var info = extracted["info"] as? ApiInfo {
                info.slug = document.slug
                info.uploadedAt = document.uploadedAt
                apiInfos.append(info)
            }
        }

        return apiInfos
    }
}
