import Foundation
import Yams

struct OpenAPIService {
    private let validMethods = ["get", "post", "put", "delete", "patch", "options", "head"]

    public func extractInfoAndEndpoints(from filePath: String) throws -> [String: Any] {
        let url = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: url)
        let ext = url.pathExtension.lowercased()

        var spec: [String: Any] = [:]

        if ext == "json" {
            spec = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
        } else if ext == "yaml" || ext == "yml" {
            if let yamlString = String(data: data, encoding: .utf8) {
                spec = try Yams.load(yaml: yamlString) as? [String: Any] ?? [:]
            }
        }
        return extractFullContent(from: spec)
    }

    public func extractInfo(from filePath: String) -> ApiInfo {
        let url = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: url)
        let ext = url.pathExtension.lowercased()

        var spec: [String: Any] = [:]

        if ext == "json" {
            spec = try! JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
        } else if ext == "yaml" || ext == "yml" {
            if let yamlString = String(data: data, encoding: .utf8) {
                spec = try! Yams.load(yaml: yamlString) as? [String: Any] ?? [:]
            }
        }
        return extractInfo(from: spec)
    }

    private func extractFullContent(from spec: [String: Any]) -> [String: Any] {
        // Extract info
        let info = extractInfo(from: spec)

        // Extract endpoints
        var endpoints: [Endpoint] = extractEndpoints(from: spec)

        // Order endpoints by method according to validMethods
        endpoints.sort { lhs, rhs in
            let lhsIndex =
                self.validMethods.firstIndex(of: lhs.method.rawValue.lowercased())
                ?? self.validMethods.count
            let rhsIndex =
                self.validMethods.firstIndex(of: rhs.method.rawValue.lowercased())
                ?? validMethods.count
            return lhsIndex < rhsIndex
        }

        return ["info": info, "endpoints": endpoints]
    }

    private func extractInfo(from spec: [String: Any]) -> ApiInfo {
        // Extract info
        let infoDict = spec["info"] as? [String: Any] ?? [:]
        return ApiInfo(
            title: infoDict["title"] as? String,
            version: infoDict["version"] as? String,
            description: infoDict["description"] as? String
        )
    }

    private func extractEndpoints(from spec: [String: Any]) -> [Endpoint] {
        var endpoints: [Endpoint] = []
        guard let paths = spec["paths"] as? [String: Any] else {
            return endpoints
        }

        for (path, pathItem) in paths {
            guard let pathItemDict = pathItem as? [String: Any] else { continue }

            for (method, operation) in pathItemDict {
                if self.validMethods.contains(method.lowercased()),
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

        return endpoints
    }
}
