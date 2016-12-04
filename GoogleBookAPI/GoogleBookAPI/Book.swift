//
//  Book.swift
//  GoogleBookAPI
//
//  Created by Karen Fuentes on 12/3/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation

class Book {
    let title: String
    let authors: [String]
    let thumbNail: String
    let  id : String
    let description: String
    
    
    init?(from Dict: [String: Any]) {
        if let identification = Dict["id"] as? String,
            let volumeInfo = Dict["volumeInfo"] as? [String:AnyObject],
            let title = volumeInfo["title"] as? String,
            let description = volumeInfo["description"] as? String,
            let authorsArray = volumeInfo["authors"] as? [String],
            let imageDict = volumeInfo["imageLinks"] as? [String: String],
            let thumbnail = imageDict["smallThumbnail"]{
            self.title = title
            self.authors = authorsArray
            self.thumbNail = thumbnail
            self.id = identification
            self.description = description
        
        }
        else {
            return nil
        }
    }
    static func parseBooks(from array:[[String:Any]]) -> [Book] {
        var books = [Book]()
        for bookDict in array {
            if let book = Book(from: bookDict) {
                books.append(book)
            }
        }
        return books
    }

}

    

