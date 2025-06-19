import Foundation

struct ApiInfo: Codable {
    var title: String?
    var version: String?
    var description: String?
}

enum ParameterLocation: String, Codable {
    case path
    case query
    case header
    case cookie
}

struct Parameter: Codable {
    var name: String
    var location: ParameterLocation  // replaces `in`
    var description: String?
    var required: Bool?
    var schema: [String: AnyCodable]?  // Using AnyCodable for dynamic schema
    var type: String?
}

struct RequestBodyContent: Codable {
    var contentType: [String: ContentSchema]
    struct ContentSchema: Codable {
        var schema: [String: AnyCodable]?
    }
}

struct RequestBody: Codable {
    var description: String?
    var required: Bool?
    var content: RequestBodyContent?
}

struct ResponseContent: Codable {
    var contentType: [String: RequestBodyContent.ContentSchema]
}

struct Response: Codable {
    var description: String
    var content: ResponseContent?
    var headers: [String: AnyCodable]?
}

struct Responses: Codable {
    var statusCode: [String: Response]
}

enum HttpMethod: String, Codable {
    case GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD
}

struct Endpoint: Codable {
    var path: String
    var method: HttpMethod
    var summary: String?
    var description: String?
    var operationId: String?
    var parameters: [Parameter]?
    var requestBody: RequestBody?
    var responses: Responses?
    var tags: [String]?
}

struct ApiData: Codable {
    var info: ApiInfo
    var endpoints: [Endpoint]
    var filename: String?
}

struct ProcessedFileData: Codable {
    var info: ApiInfo
    var endpoints: [Endpoint]
    var filename: String?
    var message: String?
}

struct SpecToSave: Codable {
    var info: ApiInfo
    var paths: [String: [String: SpecToSaveMethod]]
    struct SpecToSaveMethod: Codable {
        var summary: String?
        var description: String?
        var operationId: String?
        var parameters: [Parameter]?
        var responses: Responses?
        var requestBody: RequestBody?
    }
}

struct SaveApiResponse: Codable {
    var id: String
    var title: String
    var link: String
    var expires_at: String
    var message: String
}

struct ProxyResponse: Codable {
    var status: Int
    var statusText: String
    var headers: [String: String]
    var data: AnyCodable
}

// Helper for dynamic types
struct AnyCodable: Codable {}
