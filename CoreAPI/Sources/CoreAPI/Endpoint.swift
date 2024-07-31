//
//  File.swift
//
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//
public protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
}

extension Endpoint {
    public var headers: [String: String] { [:] }
    public var parameters: [String: Any] { [:] }
    public var url: String { "\(baseUrl)\(path)" }
}
