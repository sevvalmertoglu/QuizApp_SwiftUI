//
//  File.swift
//
//
//  Created by Şevval Mertoğlu on 29.07.2024.
//
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod

extension Endpoint {
    public var encoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default // If the HTTP method is GET, the URLEncoding.default encoding method is used.
        default: return JSONEncoding.default
        }
    }
}
