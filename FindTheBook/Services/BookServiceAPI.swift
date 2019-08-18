//
//  BookServiceAPI.swift
//  FindTheBook
//
//  Created by Giselle Tavares on 2019-08-18.
//  Copyright © 2019 Giselle Tavares. All rights reserved.
//

import Foundation

class BookServiceAPI {
    static let shared = BookServiceAPI()
    
    private init() {}
    
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://www.googleapis.com/books/v1/volumes?q=")!
    private let apiKey = "AIzaSyDRc6UcoLVGVfW8Q1b3mPZlgK6h9PFHTHA"
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    private func fetchResults<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
//        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//
//        let queryItems = [URLQueryItem(name: "key", value: apiKey)]
//        urlComponents.queryItems = queryItems
//
//        guard let url = urlComponents.url else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(response)
                print(error!.localizedDescription)
                return
            }
            guard let data = data else {
                print("no error but no data")
                print(response)
                return
            }
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []) else {
                print("the JSON is not valid")
                return
            }
            print(url)
            print(jsonResult)
            if let arrayOfTitles = (jsonResult as AnyObject).value(forKeyPath: "items.volumeInfo.title") as? [String] {
                print(arrayOfTitles)
            }
            if let arrayOfAuthors = (jsonResult as AnyObject).value(forKeyPath: "items.volumeInfo.authors") as? [[String]] {
                print(arrayOfAuthors)
            }
        }.resume()
        
//        print(url)
//        urlSession.dataTask(with: url) { (result)  in
//            switch result {
//            case .success(let(response, data)):
//                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
//                    completion(.failure(.invalidResponse))
//                    return
//                }
//                do {
//                    let values = try self.jsonDecoder.decode(T.self, from: data)
//                    completion(.success(values))
//                } catch {
//                    completion(.failure(.decodeError))
//                }
//            case .failure(let error):
//                completion(.failure(.apiError))
//            }
//        }.resume()
    }
    
    public func fetchBooks(from search: String, result: @escaping (Result<BookResponse, APIServiceError>) -> Void){
        let bookURL = URL(string: "\(baseURL)\(search)&key=\(apiKey)")
        
        print(bookURL!)
        fetchResults(url: bookURL!, completion: result)
    }
    
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
