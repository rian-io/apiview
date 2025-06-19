import Foundation

struct OpenAPIService {
    static func extractEndpoints(from spec: [String: Any]) -> [String: Any] {
        let info: [String: String] = [
            "title": (spec["info"] as? [String: Any])?["title"] as? String ?? "Unknown API",
            "version": (spec["info"] as? [String: Any])?["version"] as? String ?? "Unknown",
            "description": (spec["info"] as? [String: Any])?["description"] as? String ?? "",
        ]
        var endpoints: [[String: Any]] = []
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
                    var endpoint: [String: Any] = [
                        "path": path,
                        "method": method.uppercased(),
                        "summary": operationDict["summary"] as? String ?? "",
                        "description": operationDict["description"] as? String ?? "",
                        "operationId": operationDict["operationId"] as? String ?? "",
                        "parameters": operationDict["parameters"] as? [[String: Any]] ?? [],
                        "responses": operationDict["responses"] as? [String: Any] ?? [:],
                    ]
                    if let requestBody = operationDict["requestBody"] {
                        endpoint["requestBody"] = requestBody
                    }
                    endpoints.append(endpoint)
                }
            }
        }
        return ["info": info, "endpoints": endpoints]
    }
}
