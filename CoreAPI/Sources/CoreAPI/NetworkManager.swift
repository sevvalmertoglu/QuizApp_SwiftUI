//
//  NetworkManager.swift
//
//
//  Created by Şevval Mertoğlu on 26.07.2024.
//

import Alamofire
import Foundation

public typealias Completion<T> = (Result<T, APIClientError>) -> Void where T: Decodable

public final class NetworkManager<EndpointItem: Endpoint> {
    public init() {}
    private var possibleEmptyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200) // Successful
        defaultSet.insert(201) // Created
        return defaultSet
    }

    // sends an API request and processes the response
    public func request<T: Decodable>(endpoint: EndpointItem, type: T.Type, completion: @escaping Completion<T>) {
        // Make a Request
        AF.request(
            endpoint.url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: HTTPHeaders(endpoint.headers)
        )
        .validate() // Verify Answer
        // Processing the Response
        .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: self.possibleEmptyResponseCodes), completionHandler: { response in
            switch response.result {
            case let .success(data):
                do {
                    let decodedObject = try JSONDecoder().decode(type, from: data)
                    completion(.success(decodedObject))
                } catch {
                    let decodingError = APIClientError.decoding(error: error as? DecodingError)
                    completion(.failure(decodingError))
                }
            case let .failure(error):
                if NSURLErrorTimedOut == (error as NSError).code {
                    completion(.failure(.timeout))
                } else {
                    guard let data = response.data else {
                        completion(.failure(.networkError))
                        return
                    }
                    do {
                        let clientError = try JSONDecoder().decode(ClientError.self, from: data)
                        completion(.failure(.handledError(error: clientError)))
                    } catch {
                        let decodingError = APIClientError.decoding(error: error as? DecodingError)
                        completion(.failure(decodingError))
                    }
                }
            }
        })
    }
}
