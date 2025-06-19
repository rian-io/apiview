import Foundation

struct OpenAPIService {
    static func extractEndpoints(from spec: [String: Any]) -> [String: Any] {
        // Extract info
        let infoDict = spec["info"] as? [String: Any] ?? [:]
        let info = ApiInfo(
            title: infoDict["title"] as? String,
            version: infoDict["version"] as? String,
            description: infoDict["description"] as? String
        )
        // Extract endpoints
        var endpoints: [Endpoint] = []
        guard let paths = spec["paths"] as? [String: Any] else {
            return ["info": info, "endpoints": endpoints]
        }
        let validMethods = ["get", "post", "put", "delete", "patch", "options", "head"]
        for (path, pathItem) in paths {
            guard let pathItemDict = pathItem as? [String: Any] else { continue }
            for (method, operation) in pathItemDict {
                if validMethods.contains(method.lowercased()),
                    let operationDict = operation as? [String: Any]
                {
                    let endpoint = Endpoint(
                        path: path,
                        method: HttpMethod(rawValue: method.uppercased()) ?? .GET,
                        summary: operationDict["summary"] as? String,
                        description: operationDict["description"] as? String,
                        operationId: operationDict["operationId"] as? String,
                        parameters: nil,  // You can add parameter parsing here
                        requestBody: nil,  // You can add requestBody parsing here
                        responses: nil,  // You can add responses parsing here
                        tags: operationDict["tags"] as? [String]
                    )
                    endpoints.append(endpoint)
                }
            }
        }
        return ["info": info, "endpoints": endpoints]
    }
}
