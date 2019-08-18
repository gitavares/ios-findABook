//
//  BookTableViewCell.swift
//  FindTheBook
//
//  Created by Giselle Tavares on 2019-08-18.
//  Copyright © 2019 Giselle Tavares. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    
    func updateViews(book: Book){
        bookImage.image = UIImage(named: book.thumbnail)
        bookName.text = book.title
    }

}
