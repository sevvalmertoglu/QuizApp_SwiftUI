//
//  File.swift
//  
//
//  Created by Şevval Mertoğlu on 29.07.2024.
//
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod

public extension Endpoint {
    var encoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }
}
