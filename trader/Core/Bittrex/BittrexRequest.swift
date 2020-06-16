//
//  BinanceAPI.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import APIKit
import CryptoSwift

public protocol BittrexRequest: APIKit.Request {
    var withAuth: Bool { get }
}

extension BittrexRequest {
    private var url: URL {
        return URL(string: "https://bittrex.com")!
    }
    
    private var apiVersion: String {
        return "v1.1"
    }
    
    public var baseURL: URL {
        return url
            .appendingPathComponent("/api")
            .appendingPathComponent("/\(apiVersion)")
    }
    
    public var method: HTTPMethod {
        return .get
    }
}

extension BittrexRequest where Response: Decodable {
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
