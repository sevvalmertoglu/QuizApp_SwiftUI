//
//  ApiClientError.swift
//
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//
import Foundation

public protocol APIError: Decodable {
    var message: String { get }
    var debugMessage: String { get }
    var code: Int { get }
    var result: Bool { get }
}

struct ClientError: APIError {
    var message: String
    var debugMessage: String
    var code: Int
    var result: Bool
}

public enum APIClientError: Error {
    case handledError(error: APIError)
    case networkError
    case decoding(error: DecodingError?)
    case timeout
    case message(String)

    public var message: String {
        switch self {
        case let .handledError(error):
            return error.message
        case .decoding:
            return "An unexpected error occurred"
        case .networkError:
            return "An unexpected error occurred."
        case .timeout:
            return "The request timed out, please try again later."
        case let .message(message):
            return message
        }
    }

    public var title: String {
        switch self {
        case .handledError, .decoding, .networkError, .timeout, .message:
            return "Error"
        }
    }

    public var debugMessage: String {
        switch self {
        case let .handledError(error):
            return error.debugMessage
        case let .decoding(decodingError):
            guard let decodingError = decodingError else { return "Decode Error" }
            return "\(decodingError)"
        case .networkError:
            return "Network Error"
        case .timeout:
            return "Timeout"
        case let .message(message):
            return message
        }
    }

    public var code: Int {
        switch self {
        case let .handledError(error):
            return error.code
        default:
            return 500
        }
    }
}
