//
//  Book.swift
//  FindTheBook
//
//  Created by Giselle Tavares on 2019-08-18.
//  Copyright © 2019 Giselle Tavares. All rights reserved.
//

import Foundation

struct Volume: Decodable {
    let kind: String?
    let totalItems: Int?
    let items: [Item]?
}

struct Item: Decodable {
    let kind: String?
    let id: String?
    let etag: String?
    let selflink: String?
    let volumeInfo: Book?
}

struct Book: Decodable {
    let id: String?
    let title: String?
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let categories: [String]?
    let thumbnail: String?
    let infoLink: String?
    
}
