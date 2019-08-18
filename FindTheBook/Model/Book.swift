//
//  Book.swift
//  FindTheBook
//
//  Created by Giselle Tavares on 2019-08-18.
//  Copyright © 2019 Giselle Tavares. All rights reserved.
//

import Foundation

struct BookResponse: Codable {
    public var results: [Book]
}

struct Book: Codable {
    private(set) public var title: String
    private(set) public var subtitle: String
    private(set) public var authors: [String]
    private(set) public var publisher: String
    private(set) public var publishedDate: String
    private(set) public var description: String
    private(set) public var pageCount: Int
    private(set) public var categories: [String]
    private(set) public var thumbnail: String
    private(set) public var infoLink: String
    
    init(title: String, subtitle: String, authors: [String], publisher: String, publishedDate: String, description: String, pageCount: Int, categories: [String], thumbnail: String, infoLink: String) {
        
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.description = description
        self.pageCount = pageCount
        self.categories = categories
        self.thumbnail = thumbnail
        self.infoLink = infoLink
    }
    
}
