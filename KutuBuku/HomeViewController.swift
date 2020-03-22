//
//  HomeViewController.swift
//  KutuBuku
//
//  Created by Firza Ilhami on 13/03/20.
//  Copyright © 2020 Firza Ilhami. All rights reserved.
//

import UIKit


extension HomeViewController: AddTitleBookDelegate {
    
    // MARK: - Implementation for addTitleBook Method protocol
    
    func addTitleBook(buku: Buku) {
        self.books.append(buku)
        self.bookTitleTable.reloadData()
    }
}


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var bookTitleTable: UITableView!
    @IBOutlet weak var tambahJudulBukuTombol: UIButton!

    var books = [Buku]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitleTable.dataSource = self
        bookTitleTable.delegate = self
        
        tambahJudulBukuTombol.layer.cornerRadius = 0.5 * tambahJudulBukuTombol.bounds.size.width
        tambahJudulBukuTombol.clipsToBounds = true
        
      }
    
    // MARK: - Handling Table data
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return books.count
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookTitleCell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        bookTitleCell.textLabel?.text = books[indexPath.row].title
        bookTitleCell.detailTextLabel?.text = "\(books[indexPath.row].lastPageRead) of \( books[indexPath.row].numberOfPage!)"
        return(bookTitleCell)
    }
   
    // MARK: - Handling the segue for the next UIView controller

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailReadTime" {
            let destinationView = segue.destination as? ViewController
            if let index = self.bookTitleTable.indexPathForSelectedRow {
                destinationView?.title = books[index.row].title
            }
            
        } else if segue.identifier == "showPopUp" {
            let destinationView = segue.destination as? BukuViewController
            destinationView?.delegate = self
        }
        
       
    }

}
