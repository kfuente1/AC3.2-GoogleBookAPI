//
//  BookTableViewController.swift
//  GoogleBookAPI
//
//  Created by Karen Fuentes on 12/4/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    var allBooks = [Book]()
    let identifier = "BookCell"
    var searchQuery = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData(searchTerm: String = "bananana") {
    let queryString = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    let bookEndpoint = "https://www.googleapis.com/books/v1/volumes?q=\(queryString!))"
        APIRequestManager.manager.getData(endPoint: bookEndpoint) { (data:Data?) in
        if let validData = data {
            if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []) {
                if let wholeDict = jsonData as? [String:Any],
                   let items = wholeDict["items"] as? [[String:Any]] {
                    self.allBooks = Book.parseBooks(from: items)
                        DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.title = searchTerm
                                self.searchQuery = searchTerm
                    }
                }
            }
        }
    }
}

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allBooks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!BookTableViewCell
        
        cell.BookTitle.text = allBooks[indexPath.row].title
        APIRequestManager.manager.getData(endPoint: allBooks[indexPath.row].thumbNail) { (data: Data?) in
            DispatchQueue.main.async {
                cell.thumbNailImage.image = UIImage(data: data!)
            }

        }

        return cell
    }
 // MARK: - Search Bar Delegate 
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            loadData(searchTerm: text)
        }
        
        searchBar.showsCancelButton = false
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailViewController,
        let cell = sender as? BookTableViewCell,
        let indexpath = tableView.indexPath(for: cell) {
            destination.selectedBook = allBooks[indexpath.row]
            destination.id = allBooks[indexpath.row].id 
        }
    }
 

}
