import Foundation
import Vapor

enum ParameterLocation: String, Codable {
    case path
    case query
    case header
    case cookie
}

enum HttpMethod: String, Codable {
    case GET, POST, PUT, DELETE, PATCH, OPTIONS, HEAD
}

struct ApiInfo: Codable, Content {
    var title: String?
    var version: String?
    var description: String?
    var slug: String?
    var uploadedAt: Date?
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

struct ProcessedFileData: Codable, AsyncResponseEncodable {
    var info: ApiInfo
    var endpoints: [Endpoint]
    var filename: String?
    var message: String?

    func encodeResponse(for request: Vapor.Request) async throws -> Vapor.Response {
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "application/json")
        return .init(
            status: .ok, headers: headers,
            body: .init(data: try JSONEncoder().encode(self))
        )
    }
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
