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
        guard NSPredicate(format: "SELF MATCHES %@", slugRegex).evaluate(with: slug) else {
            throw Abort(
                .badRequest,
                reason:
                    "Invalid slug format. Must be 8 characters long and contain only alphanumeric characters."
            )
        }

        return try await ProcessedFileService.getProcessedFileDataBySlug(slug, req: req)
    }

    @Sendable
    func getAllInfo(req: Request) async throws -> [ApiInfo] {
        return try await ProcessedFileService.getAllInfo(req: req)
    }
}
