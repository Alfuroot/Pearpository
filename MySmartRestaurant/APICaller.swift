//
//  FMAPI.swift
//  MySmartRestaurant
//
//  Created by Francesco De Marco on 19/01/23.
//
import Foundation

public struct APICaller {
    
    public let baseURI = "https://napoli.fm-testing.com/fmi/odata/v4/MySmartRestaurant"
    
    struct JSONValue<T: Codable>: Codable {
        var value: [T]
    }
    
    var username: String
    var password: String
    var auth: String {(username + ":" + password).data(using: .utf8)!.base64EncodedString()}
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public func getFromFM<T: Codable>(urlTmp: String) async throws -> [T] {
        
        guard let url = URL(string: urlTmp) else {
            throw URLError(.badURL)
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        //        Execution of the API call
        let (data, response) = try await URLSession.shared.data(for: request)
        //        Checking for an error
        
        if (response as? HTTPURLResponse)?.statusCode ?? 500 < 300 {
        } else {
            throw HTTPErrors.httpError
        }
        
        do {
            let fetchedData = try JSONDecoder().decode(JSONValue<T>.self, from: data)
            return fetchedData.value
        } catch {
            print("Decode Error")
            throw error
        }
    }
    
    public func createRecordInFM<T: Codable>(urlTmp: String, data: T) async throws {
        
        guard let url = URL(string: urlTmp) else {
            throw URLError(.badURL)
        }
        var request: URLRequest = URLRequest(url: URL(string: urlTmp)!)
        
        request.url = url
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let encoded = try? JSONEncoder().encode(data) else {
            throw CodableError.encode
        }
        
        //        Execution of the API call
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        
        //        Checking for an error
        if (response as? HTTPURLResponse)?.statusCode ?? 500 < 300 {
        } else {
            throw HTTPErrors.httpError
        }
    }
    
    public func deleteRecordInFM<T: Codable>(urlTmp: String, data: T) async throws {
        
        guard let url = URL(string: urlTmp) else {
            throw URLError(.badURL)
        }
        var request: URLRequest = URLRequest(url: URL(string: urlTmp)!)
        
        request.url = url
        
        request.httpMethod = "DELETE"
        
        
        //        Execution of the API call
        let (_, response) = try await URLSession.shared.data(for: request)
        
        //        Checking for an error
        if (response as? HTTPURLResponse)?.statusCode ?? 500 < 300 {
        } else {
            throw HTTPErrors.httpError
        }
    }
}


/// Enumeration of all the possible HTTP method of the FMOData protocol
public enum HTTPErrors: Error {
    case httpError
}

public enum CodableError: Error {
    case encode
    case decode
}
