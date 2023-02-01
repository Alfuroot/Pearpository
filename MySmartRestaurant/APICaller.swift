//
//  FMAPI.swift
//  MySmartRestaurant
//
//  Created by Francesco De Marco on 19/01/23.
//
import Foundation

public class APICaller: ObservableObject {
    
    public let baseURI = "https://napoli.fm-testing.com/fmi/odata/v4/MySmartRestaurant"
    
    // Because FileMaker gives you an array of value.
    struct JSONValue<T: Codable>: Codable {
        var value: [T]
    }
    
    var username: String
    var password: String
    var auth: String {(username + ":" + password).data(using: .utf8)!.base64EncodedString()}
    
    // To set username and password
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public func getFromFM<T: Codable>(urlTmp: String) async throws -> [T] {
        
        guard let url = URL(string: urlTmp) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
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
            // In this way we receive an array of elements, not value but its content.
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
        var request = URLRequest(url: URL(string: urlTmp)!)
        
        request.url = url
        
        request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let encoded = try? JSONEncoder().encode(data) else {
            throw CodableError.encode
        }
        
        print(String(data: encoded, encoding: .utf8))
        //        Execution of the API call
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        
        //        Checking for an error
        if (response as? HTTPURLResponse)?.statusCode ?? 500 < 300 {
        } else {
            print((response as? HTTPURLResponse)!.statusCode)
            throw HTTPErrors.httpError
        }
    }
    

    public func editRecordInFM<T: Codable>(urlTmp: String, data: T) async throws {
        
        print(urlTmp)
        guard let url = URL(string: urlTmp) else {
            print("url Error")
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: URL(string: urlTmp)!)
        
        request.url = url
                
        request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "PATCH"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let encoded = try? JSONEncoder().encode(data) else {
            throw CodableError.encode
        }
        
        print(request.url)
        print(String(data: encoded, encoding: .utf8))
        //        Execution of the API call
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        
        //        Checking for an error
        if (response as? HTTPURLResponse)?.statusCode ?? 500 < 300 {
        } else {
            print((response as? HTTPURLResponse)!.statusCode)
            throw HTTPErrors.httpError
        }
    }
    
    public func deleteRecordInFM(urlTmp: String) async throws {
        
        guard let url = URL(string: urlTmp) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: URL(string: urlTmp)!)
        
        request.url = url
        
        request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        
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
