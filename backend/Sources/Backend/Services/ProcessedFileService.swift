import Vapor

struct ProcessedFileService {
    func getProcessedFileDataBySlug(_ slug: String, req: Request) async throws -> ProcessedFileData
    {
        let apiDocumentRecord = try! await req.application.apiDocumentRepository
            .getAPIDocumentBySlug(
                slug, db: req.db)

        let fileName = apiDocumentRecord.slug + "." + apiDocumentRecord.filetype
        let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
        let filePath = uploadsDirectory + fileName

        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Abort(.notFound, reason: "File \(fileName) not found")
        }

        let extracted = try req.application.openAPIService.extractInfoAndEndpoints(from: filePath)

        return ProcessedFileData(
            info: extracted["info"] as? ApiInfo ?? ApiInfo(title: "Unknown", version: "1.0"),
            endpoints: extracted["endpoints"] as? [Endpoint] ?? [],
            filename: fileName,
            message: "OK"
        )
    }

    func getApiInfoBySlug(_ slug: String, req: Request) async throws -> ApiInfo {
        let apiDocumentRecord = try! await req.application.apiDocumentRepository
            .getAPIDocumentBySlug(
                slug, db: req.db)

        let fileName = apiDocumentRecord.slug + "." + apiDocumentRecord.filetype
        let uploadsDirectory = req.application.directory.publicDirectory + "Uploads/"
        let filePath = uploadsDirectory + fileName

        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Abort(.notFound, reason: "File \(fileName) not found")
        }

        let extracted = try req.application.openAPIService.extractInfoAndEndpoints(from: filePath)

        return extracted["info"] as? ApiInfo ?? ApiInfo(title: "Unknown", version: "1.0")
    }

    func getAllInfo(req: Request) async throws -> [ApiInfo] {
        let apiDocuments = await req.application.apiDocumentRepository.getAllAPIDocuments(
            db: req.db)

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

            let extracted = req.application.openAPIService.extractInfo(from: filePath)
            apiInfos.append(extracted)
        }

        return apiInfos
    }
}
