//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import APIKit
import CryptoSwift

public struct HTTPRequest<Request: BittrexRequest>: APIKit.Request {
    private let baseRequest: Request
    private let auth: AuthBittrex
    private let nonce: String
    
    public init(_ baseRequest: Request, auth: AuthBittrex, nonce: String) {
        self.baseRequest = baseRequest
        self.auth = auth
        self.nonce = nonce
    }
    
    public var baseURL: URL {
        return baseRequest.baseURL
    }
    
    public var path: String {
        return baseRequest.path
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var parameters: Any? {
        var parameters: [String: Any]
        if let originalParameters = baseRequest.parameters as? [String: Any] {
            parameters = originalParameters
        } else {
            parameters = [:]
        }
        
        if baseRequest.withAuth {
            parameters["apikey"] = auth.apiKey
            parameters["nonce"] = nonce
        }
        
        return parameters
    }
    
    public var headerFields: [String: String] {
        guard let uri = buildURI(), baseRequest.withAuth else {
            return [:]
        }

        guard let sign = uri.hmac(secret: auth.apiSecret) else {
            fatalError("Bittrex: HMAC failed")
        }
        
        return ["apisign": sign]
    }
    
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Request.Response {
        return try baseRequest.response(from: object, urlResponse: urlResponse)
    }
    
    private func buildURI() -> String? {
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            components.percentEncodedQuery = URLEncodedSerialization.string(from: queryParameters)
        }
        
        guard let uri = components.url?.absoluteString else {
            return nil
        }
        
        return uri
    }
}
