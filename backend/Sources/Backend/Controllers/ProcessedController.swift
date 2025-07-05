import Vapor

struct ProcessedController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let details = routes.grouped("view")
        details.get(use: self.getAllInfo)
        details.get(":slug", use: self.getDetails)
    }

    @Sendable
    func getDetails(req: Request) async throws -> ProcessedFileData {
        guard let slug = req.parameters.get("slug") else {
            throw Abort(
                .badRequest,
                reason: "A file identifier (slug) must be provided in the path.")
        }

        // Validate slug format: alphanumeric only and length equal to 8
        let slugRegex = "^[a-zA-Z0-9]{8}$"
        guard slug.range(of: slugRegex, options: .regularExpression) != nil else {
            throw Abort(
                .badRequest,
                reason:
                    "Invalid slug format. Must be 8 characters long and contain only alphanumeric characters."
            )
        }

        // Usa a instância registrada no Application
        return try await req.application.processedFileService.getProcessedFileDataBySlug(
            slug, req: req)
    }

    @Sendable
    func getAllInfo(req: Request) async throws -> [ApiInfo] {
        // Usa a instância registrada no Application
        return try await req.application.processedFileService.getAllInfo(req: req)
    }
}
