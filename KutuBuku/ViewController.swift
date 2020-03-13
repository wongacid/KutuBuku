//
//  ViewController.swift
//  KutuBuku
//
//  Created by Firza Ilhami on 05/03/20.
//  Copyright © 2020 Firza Ilhami. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var timer = Timer()
    var (hours, minutes, seconds, fractions) = (0, 0, 0, 0)
    var buku: [String] = [ ]
    var judulBuku: String = ""
    var halamanTerakhir: [String] = []
    var elapseTimeRead: [String] = []
    var cellElapseTimeRead = ""
    var hariIni: [String] = []
    
   
    let dateFormater = DateFormatter()
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //stopButtonTombol.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //stopButtonTombol.color
        disableStopTombol()
        judulBukuLabel.text = ""
        
        listBukuTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
      
    
    @IBOutlet weak var fractionsLabel: UILabel!
    
   
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var addButtonTombol: UIButton!
    @IBOutlet weak var stopButtonTombol: UIButton!
    @IBOutlet weak var judulBukuLabel: UILabel!
   
    
    
    @IBOutlet weak var listBukuTable: UITableView!
    
    
    private func disableStopTombol(){
        //stopButtonTombol.setTitleColor(.gray, for: .normal)
        stopButtonTombol.isUserInteractionEnabled = false
        stopButtonTombol.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
    }
    
    private func enableStopTombol(){
        stopButtonTombol.isUserInteractionEnabled = true
        //stopButtonTombol.setTitleColor(.white, for: .normal)
        stopButtonTombol.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    private func disableAddTombol(){
        addButtonTombol.isUserInteractionEnabled = false
        //addButtonTombol.setTitleColor(.gray, for: .normal)
        addButtonTombol.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
    }
    
    private func enableAddTombol(){
        addButtonTombol.isUserInteractionEnabled = true
        //addButtonTombol.setTitleColor(UIColor.systemBlue, for: .normal)
        addButtonTombol.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        
        disableAddTombol()
        enableStopTombol()
        showInputBookTitle()
        //stopButtonTombol.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        timer.invalidate()
        (hours, minutes, seconds, fractions) = (0, 0, 0, 0)
        hourLabel.text = "00"
        minuteLabel.text = "00"
        secondLabel.text = "00"
        fractionsLabel.text = ".00"
        
        enableAddTombol()
        disableStopTombol()
        showInputLastPage()
    }
    
    @objc func keepTimer(){
        fractions += 1
        
        if fractions > 99{
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        if minutes == 60 {
            hours += 1
            minutes = 0
        }
        
        let secondString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minuteString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let hourString = hours > 9 ? "\(hours)" : "0\(hours)"
        let fractionString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        
        if hours <= 0 {
            cellElapseTimeRead = "\(minutes)m"
        }else {
            cellElapseTimeRead = "\(hours)h : \(minutes)m"
        }
        //hourLabel.textAlignment = .right
        //minuteLabel.textAlignment = .right
        hourLabel.text = "\(hourString)"
        minuteLabel.text = "\(minuteString)"
        secondLabel.text = "\(secondString)"
        fractionsLabel.text = ".\(fractionString)"
        
    }
    
    public func showInputBookTitle(){
        let alertController = UIAlertController(title: "Book Title", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let bacaAction = UIAlertAction(title: "Baca", style: .default) { _ in
            if let bukuTextField = alertController.textFields?.first?.text {
                let errorLabel = UILabel(frame: CGRect(x: 0, y: 40, width: 270, height: 18))
                errorLabel.textAlignment = .center
                errorLabel.textColor = .red
                errorLabel.font =  errorLabel.font.withSize(12)
                alertController.view.addSubview(errorLabel)
                
                if bukuTextField.isEmpty {
                    //alertController.message = "jangan kosong"
                    errorLabel.text = "Please fill the Book Title"
                    self.present(alertController, animated: true, completion: nil)
                }else {
                    self.judulBukuLabel.text = bukuTextField
                    self.judulBukuLabel.font = UIFont.boldSystemFont(ofSize: 17)
                    self.judulBuku = bukuTextField
                    self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.keepTimer), userInfo: nil, repeats: true)
                }
            }
        }
        
        alertController.addAction(bacaAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    public func isPageNumber(checkString: String) -> Bool{
        return Int(checkString) != nil
    }
    
    public func showInputLastPage() {
        let alertController = UIAlertController(title: "Last Page", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let lastPageAction = UIAlertAction(title: "Rekap", style: .default) { _ in
            if let lastPage = alertController.textFields?.first?.text {
                let errorLabel = UILabel(frame: CGRect(x: 0, y: 40, width: 270, height: 18))
                errorLabel.textAlignment = .center
                errorLabel.textColor = .red
                errorLabel.font =  errorLabel.font.withSize(12)
               
                if lastPage.isEmpty {
                    //errorLabel.text = "Please Fill with number of Last Page Read"
                    errorLabel.text = "Please don't leave blank"
                    alertController.view.addSubview(errorLabel)
                    self.present(alertController, animated: true, completion: nil)
                    
                }else if  !self.isPageNumber(checkString: lastPage) {
                    errorLabel.text = "Please fill with Page Number"
                    alertController.view.addSubview(errorLabel)
                    self.present(alertController, animated: true, completion: nil)
                }else  {
                    self.halamanTerakhir.append(lastPage)
                    self.buku.append(self.judulBuku)
                    self.elapseTimeRead.append(self.cellElapseTimeRead)
                    self.judulBukuLabel.text = ""
                    self.dateFormater.dateStyle = .medium
                    self.dateFormater.timeStyle = .short
                    let currentDate = Date()
                    self.hariIni.append(self.dateFormater.string(from: currentDate))
                    
                                        
                    self.listBukuTable.reloadData()
                }
                
            }
    
        }
        
        alertController.addAction(lastPageAction)
        present(alertController, animated: true, completion: nil)
        
        

    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return buku.count
        
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listBuku = tableView.dequeueReusableCell(withIdentifier: "listBuku", for: indexPath)
        listBuku.textLabel?.textColor = #colorLiteral(red: 1, green: 0.5644097924, blue: 0, alpha: 1)
        listBuku.textLabel?.text = buku[indexPath.row]
        listBuku.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        listBuku.detailTextLabel?.text = "\(elapseTimeRead[indexPath.row]) of reading on \(hariIni[indexPath.row])"
        

        let labelPage = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
       // labelPage.font = labelPage.font.withSize(12)
        labelPage.font = UIFont.boldSystemFont(ofSize: 12)
        labelPage.text = "Page:  \(self.halamanTerakhir[indexPath.row])"
        labelPage.textColor = #colorLiteral(red: 1, green: 0.5644097924, blue: 0, alpha: 1)
        labelPage.textAlignment = .left
        listBuku.accessoryView = labelPage
 
        return(listBuku)
    }
    

    
}

