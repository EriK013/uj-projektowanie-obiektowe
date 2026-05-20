import Fluent
import Vapor

struct ProductController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let products = routes.grouped("products")

        products.get(use: self.index)
        products.post(use: self.create)
        products.group(":productID") { product in
            product.get(use: self.show)
            product.put(use: self.update)
            product.delete(use: self.delete)
        }
    }

    @Sendable
    func index(req: Request) async throws -> [Product] {
        try await Product.query(on: req.db).all()
    }

    @Sendable
    func show(req: Request) async throws -> Product {
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return product
    }

    @Sendable
    func create(req: Request) async throws -> Product {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)
        return product
    }

    @Sendable
    func update(req: Request) async throws -> Product {
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updated = try req.content.decode(Product.self)
        product.name = updated.name
        product.price = updated.price
        try await product.save(on: req.db)
        return product
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let product = try await Product.find(req.parameters.get("productID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return .noContent
    }
}
