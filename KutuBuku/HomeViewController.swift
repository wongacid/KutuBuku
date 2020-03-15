//
//  HomeViewController.swift
//  KutuBuku
//
//  Created by Firza Ilhami on 13/03/20.
//  Copyright © 2020 Firza Ilhami. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var bookTitleTable: UITableView!

    @IBOutlet weak var tambahJudulBukuTombol: UIButton!
    
    let bookTitle: [String] = ["Arjuna Mencari Cinta","Harry Potter"]
    var buku = Buku()
    var listBuku: [Buku] = []
    var currentIndexSelected: Int = 0
  
    //what must be done afer load the view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting for UITableView
        bookTitleTable.dataSource = self
        bookTitleTable.delegate = self
        
        tambahJudulBukuTombol.layer.cornerRadius = 0.5 * tambahJudulBukuTombol.bounds.size.width
        tambahJudulBukuTombol.clipsToBounds = true
        
      
      }
    
    //listing book table within table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return bookTitle.count
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookTitleCell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        bookTitleCell.textLabel?.text = bookTitle[indexPath.row]
        buku.addTitle(judulBuku: bookTitle[indexPath.row])
        listBuku.append(buku)
        return(bookTitleCell)
    }
   
    //Prepare the data so that it can be accessed in the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationView = segue.destination as? ViewController
        if let index = self.bookTitleTable.indexPathForSelectedRow {
            destinationView?.title = listBuku[index.row].title
        }
        
       
    }

}
