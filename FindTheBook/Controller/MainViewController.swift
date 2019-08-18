//
//  ViewController.swift
//  FindTheBook
//
//  Created by Giselle Tavares on 2019-08-17.
//  Copyright © 2019 Giselle Tavares. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var booksTableView: UITableView!
    @IBOutlet weak var txtSeach: TextField!
    @IBOutlet weak var lblQuerySearch: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksTableView.dataSource = self
        booksTableView.delegate = self
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        lblQuerySearch.text = "Result for: \(String(describing: txtSeach.text!))"
        BookServiceAPI.shared.fetchBooks(from: txtSeach.text!) { (result: Result<BookResponse, BookServiceAPI.APIServiceError>) in
            
            print(result)
            switch result {
                case .success(let bookResponse):
                    print(bookResponse.results)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataService.instance.getBooks().count == 0 {
            self.booksTableView.setEmptyMessage()
        } else {
            self.booksTableView.restore()
        }

        return DataService.instance.getBooks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as? BookTableViewCell {
            let book = DataService.instance.getBooks()[indexPath.row]
            cell.updateViews(book: book)
            
            return cell
        } else {
            return BookTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = DataService.instance.getBooks()[indexPath.row]
        performSegue(withIdentifier: "bookVC", sender: book)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bookVC = segue.destination as? BookViewController{
            
        }
    }

}

extension UITableView {
    func setEmptyMessage() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width/2, height: self.bounds.size.height))
        messageLabel.text = "Search for a book by \nthe title, keywords, author, \netc."
        messageLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        messageLabel.numberOfLines = 3
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Avenir Book", size: 17.0)
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore(){
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

