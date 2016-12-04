//
//  ViewController.swift
//  GoogleBookAPI
//
//  Created by Karen Fuentes on 12/3/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var selectedBook: Book!
    var id: String! 
    var author = ""
  

    @IBOutlet weak var bookauthors: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var HDBookImage: UIImageView!
    
    override func viewDidLoad() {
        getBookStuff()
        super.viewDidLoad()
        self.bookTitle.text = selectedBook.title
        self.bookDescription.text = selectedBook.description
        
        if selectedBook.authors.count > 0 {
            for i in 0..<selectedBook.authors.count {
                if i != selectedBook.authors.count - 1 {
                author += "\(selectedBook.authors[i])"
            }
                else {
                    author += "\(selectedBook.authors[i])"
                }
            }
        }
        self.bookauthors.text = author
    }
    
    func getBookStuff() {
        let idString = id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let imageUrl = "https://www.googleapis.com/books/v1/volumes/\(idString)"
        APIRequestManager.manager.getData(endPoint: imageUrl) { (data:Data?) in
            DispatchQueue.main.async {
                self.HDBookImage.image = UIImage(data: data!)
            }
        }

    }

   
}

