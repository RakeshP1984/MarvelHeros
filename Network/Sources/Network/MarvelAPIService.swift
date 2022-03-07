//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation
import CryptoKit
import Domain

extension String {
    func md5() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!)
            .map { String(format: "%02hhx", $0) }
            .joined()
    }
}

struct MarvelAPIConstants {
    static var publicKey: String = "25fd89821d26a8aa8c8b16e49b75b787"
    static var privateKey: String = "cbfd7d2f157bd7fbf1c327a5e34857f0e470618c"
    static var baseURL: String = "https://gateway.marvel.com:443/v1/public"
}

extension URLSessionDataTask: Task {}

extension URLComponents {
    mutating func addParams( params: [String: String]) {
        for param in params {
            self.queryItems?.append(URLQueryItem(name: param.key, value: param.value))
        }
    }
}

public struct MarvelAPIService: ServiceProvider {
    private let publicKey: String
    private let privateKey: String
    private let baseURL: URL
    private let decoder: JSONDecoder

    public static let shared = MarvelAPIService( publicKey: MarvelAPIConstants.publicKey,
                                                 privateKey: MarvelAPIConstants.privateKey,
                                                 baseURL: URL(string: MarvelAPIConstants.baseURL)!,
                                                 decoder: JSONDecoder())

    private func hash( timeStamp: String) -> String {
        let hash = "\(timeStamp)\(privateKey)\(publicKey)".md5()
        return hash
    }

    private func comunicateResult<T: Decodable>(result: Result<T, APIError>,
                                                completionHandler:@ escaping (Result<T, APIError>) -> Void) {
        DispatchQueue.main.async {
            completionHandler(result)
        }
    }
    
    private func urlRequest(endPoint:Endpoint, params:[String:String]? = nil) -> URLRequest {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = hash(timeStamp: timestamp)
        let apikey = publicKey

        let queryURL = self.baseURL.appendingPathComponent(endPoint.path())
        var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: apikey)
        ]

        if let params = endPoint.params() {
            urlComponents.addParams(params: params)
        }

        if let params = params {
            urlComponents.addParams(params: params)
        }
        return URLRequest(url: urlComponents.url!)
    }

    @discardableResult
    public func GET<T:Decodable>( endPoint:Endpoint,
                                  params:[String:String]? = nil,
                                  completionHandler:@escaping (Result<T,APIError>) -> Void) -> Task {
        var request = self.urlRequest(endPoint: endPoint, params: params)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                self.comunicateResult(result: .failure(.noResponse), completionHandler: completionHandler)
                return
            }
            guard error == nil else {
                self.comunicateResult(result: .failure(.networkError(error!)), completionHandler: completionHandler)
                return
            }
            do {
                let object = try self.decoder.decode(T.self, from: data)
                self.comunicateResult(result: .success(object), completionHandler: completionHandler)
            } catch let error {
                self.comunicateResult(result: .failure(.jsonDecodingError(error)), completionHandler: completionHandler)
            }
        }
        task.resume()
        return task
    }
}
