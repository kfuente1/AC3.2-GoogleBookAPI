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
    var justOneBook: Book!
    
    @IBOutlet weak var bookauthors: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var HDBookImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBookStuff()
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
        let imageUrl = "https://www.googleapis.com/books/v1/volumes/\(idString!)"
        APIRequestManager.manager.getData(endPoint: imageUrl) { (data:Data?) in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []) {
                    if let oneDict = jsonData as? [String:Any] {
                        self.justOneBook = Book.parseOneBook(from: oneDict)
                        DispatchQueue.main.async {
                            self.grabBiggestImage(bookImgDict: self.justOneBook.imageDict)
                        }
                    }
                }
            }
        }
    }
    
    func grabBiggestImage(bookImgDict: [String:String]) {
     let largeImg =  bookImgDict["smallThumbnail"]!
        APIRequestManager.manager.getData(endPoint:largeImg) { (data:Data?) in
            DispatchQueue.main.async {
                self.HDBookImage.image = UIImage(data: data!)
            }
        }
        
    }
    
//    self.HDBookImage.image = UIImage(data: data!)
//    self.HDBookImage.setNeedsLayout()
    
}

