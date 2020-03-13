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
    
    let bookTitle: [String] = ["Arjuna Mencari Cinta","Harry Potter"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookTitleCell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        bookTitleCell.textLabel?.text = bookTitle[indexPath.row]
        return(bookTitleCell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

           // Segue to the second view controller
           self.performSegue(withIdentifier: "toDetailReadTime", sender: self)
       }


    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitleTable.dataSource = self
        bookTitleTable.delegate = self
        //self.

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
