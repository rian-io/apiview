import Fluent
import Vapor

// API version constant that can be changed in one place
let apiVersionV1 = "v1"

func routes(_ app: Application) throws {
    // Create the base API route group
    let apiV1 = app.grouped(.constant("api"), .constant(apiVersionV1))

    // Register controllers with the api group
    try apiV1.register(collection: HealthController())
    try apiV1.register(collection: FileUploadController())
    try apiV1.register(collection: ProcessedController())
}
