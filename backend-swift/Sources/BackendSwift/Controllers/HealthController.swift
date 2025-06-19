import Vapor

struct HealthController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let health = routes.grouped("health")
        health.get(use: self.check)
    }

    @Sendable
    func check(req: Request) async throws -> [String: String] {
        [
            "status": "ok",
            "endpoint": "/api/\(apiVersionV1)/health",
        ]
    }
}
