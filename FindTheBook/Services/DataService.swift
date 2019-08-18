//
//  DataService.swift
//  FindTheBook
//
//  Created by Giselle Tavares on 2019-08-18.
//  Copyright © 2019 Giselle Tavares. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let books = [Book]()
    
    func getBooks() -> [Book] {
        return books
    }
}
