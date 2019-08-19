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
    
    public func fetchTheBooks(from search: String) {
        let bookURL = URL(string: "\(baseURL)\(search)")!
        
        URLSession.shared.dataTask(with: bookURL) { (data, result, error) in
            let decoder = JSONDecoder()
            do {
                let values = try decoder.decode(Volume.self, from: data!)
                print(values)
                print(values.items?.count)
                
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
}
