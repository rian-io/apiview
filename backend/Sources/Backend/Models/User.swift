import Fluent
import Vapor

final class User: Model, Content, @unchecked Sendable {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "email")
    var email: String

    @Field(key: "passwordHash")
    var passwordHash: String?

    @Field(key: "provider")
    var provider: String?

    @Field(key: "providerId")
    var providerId: String?

    init() {}

    init(
        id: UUID? = nil, email: String, passwordHash: String? = nil, provider: String? = nil,
        providerId: String? = nil
    ) {
        self.id = id
        self.email = email
        self.passwordHash = passwordHash
        self.provider = provider
        self.providerId = providerId
    }
}
