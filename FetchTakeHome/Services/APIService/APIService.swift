//
//  APIService.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit

final class APIService: APIServiceProtocol {
        
    func getRecipes() async throws -> [Recipe] {
        
        do {
            
            let data = try await buildRequest(
                method: .get,
                path: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
            )
            
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            if let recipesJSON = json?["recipes"] as? [[String: Any]] {

                let data = try JSONSerialization.data(withJSONObject: recipesJSON)
                let recipes: [Recipe] = try parseData(data: data)
                
                return recipes
                
            }
            
            throw APIError.decodingFailed
            
        }
        catch {
            throw error
        }
        
    }
    
    func getMalformedRecipes() async throws -> [Recipe] {
        
        do {
            
            let data = try await buildRequest(
                method: .get,
                path: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
            )
            
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            if let recipesJSON = json?["recipes"] as? [[String: Any]] {

                let data = try JSONSerialization.data(withJSONObject: recipesJSON)
                let recipes: [Recipe] = try parseData(data: data)
                
                return recipes
                
            }
            
            throw APIError.decodingFailed
            
        }
        catch {
            throw error
        }
        
    }
    
    func getImage(url: URL) async throws -> UIImage? {
        
        do {
         
            let data = try await buildRequest(
                method: .get,
                path: url.absoluteString
            )
            
            let image = UIImage(data: data)
            return image
            
        }
        catch {
            throw error
        }
        
    }
    
}

extension APIService {
    
    internal enum APIError: Error {
        
        case invalidURL
        case invalidResponse
        case decodingFailed
        case serverError(statusCode: Int, message: String)
        
    }
    
    internal enum HTTPRequestMethod: String {
        
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
        case head = "HEAD"
        
    }
    
    func buildRequest(
        method: HTTPRequestMethod,
        path: String,
        queryParameters: [String: String]? = [:],
        parameters: [String: Any] = [:]) async throws -> Data {
            
            guard var urlComponents = URLComponents(string: path) else {
                throw APIError.invalidURL
            }
            
            urlComponents.queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
            
            guard let url = urlComponents.url else {
                throw APIError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            if !parameters.isEmpty {
                
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: parameters,
                    options: []
                )
                
                request.setValue(
                    "application/json",
                    forHTTPHeaderField: "Content-Type"
                )
                
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let error = handleErrorResponse(data: data, response: response) {
                throw error
            }
            
            return data
            
        }
    
    func parseData<T: Decodable>(data: Data) throws -> T {
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }
        catch {
            throw APIError.decodingFailed
        }
        
    }
    
    private func handleErrorResponse(data: Data,
                                     response: URLResponse) -> APIError? {
        
        let errorJson = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        let errorMessage = errorJson?["error"] as? String
        
        if let httpResponse = response as? HTTPURLResponse {
            
            let statusCode = httpResponse.statusCode
           
            let badStatusCodes = 400...599
            
            if badStatusCodes.contains(statusCode) {
                
                return APIError.serverError(
                    statusCode: statusCode,
                    message: errorMessage ?? "Oh No! Something went wrong! Please try again later."
                )
                
            }
            
        }
        
        return nil
        
    }
    
}
