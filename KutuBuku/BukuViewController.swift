//
//  BukuViewController.swift
//  KutuBuku
//
//  Created by Firza Ilhami on 15/03/20.
//  Copyright © 2020 Firza Ilhami. All rights reserved.
//

import UIKit

extension BukuViewController: UITextFieldDelegate {
    
    //
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.enableSaveButton()
        bookTitleTF.layer.borderColor = UIColor.clear.cgColor
        numberOfPageTF.layer.borderColor = UIColor.clear.cgColor
    }
    
    // While typing within text field clear border color
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        bookTitleTF.layer.borderColor = UIColor.clear.cgColor
        numberOfPageTF.layer.borderColor = UIColor.clear.cgColor
        return true
    }

}

protocol AddTitleBookDelegate {
    func addTitleBook(buku: Buku)
}

class BukuViewController: UIViewController {

    var delegate: AddTitleBookDelegate?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bookTitleTF: UITextField!
    @IBOutlet weak var numberOfPageTF: UITextField!
    @IBOutlet weak var newBookView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disabledSaveButton()
        
        // Delegate all textfield for several behaviour. Check implementation of UITextFieldDelegate protocol above
        bookTitleTF.delegate = self
        numberOfPageTF.delegate = self
    
    }
    
    @IBAction func closeModalView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        // Checking
        if self.bookTitleTF.text!.isEmpty || self.numberOfPageTF!.text!.isEmpty {
            if self.bookTitleTF.text!.isEmpty {
                redAlertTFBorder(inputTF: bookTitleTF)
                shakeView(view: newBookView)
                bookTitleTF.placeholder = "Please fill with book title"
            }
            
            if self.numberOfPageTF.text!.isEmpty {
                redAlertTFBorder(inputTF: numberOfPageTF)
                shakeView(view: newBookView)
                numberOfPageTF.placeholder = "Please fill with number of page"
            }
            
        }else if !isPageNumber(checkString: numberOfPageTF.text!) {
            redAlertTFBorder(inputTF: numberOfPageTF)
            shakeView(view: newBookView)
            numberOfPageTF.text = "Please fill with number"
        }else {
            let buku = Buku(title: self.bookTitleTF.text, numberOfPage: Int(self.numberOfPageTF!.text!))
            delegate?.addTitleBook(buku: buku)
            
            dismiss(animated: true, completion: nil)
        }        
    }
    
    // Physically shake the view function
    func shakeView(view: UIView) {
        let viewShakeAnimation = CABasicAnimation(keyPath: "position")
        viewShakeAnimation.duration = 0.07
        viewShakeAnimation.repeatCount = 2
        viewShakeAnimation.autoreverses = true
        viewShakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        viewShakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        view.layer.add(viewShakeAnimation, forKey: "position")
    }
    
    // Disable save button
    func disabledSaveButton() {
        saveButton.isEnabled = false
        saveButton.setTitleColor(UIColor.gray, for: .normal)
    }
    
    // Enable save button
    func enableSaveButton() {
        saveButton.isEnabled = true
        saveButton.setTitleColor(UIColor.systemBlue, for: .normal)
    }
    
    func isPageNumber(checkString: String) -> Bool{
        return Int(checkString) != nil
    }
    
    func redAlertTFBorder ( inputTF: UITextField ) {
        inputTF.layer.masksToBounds = true
        inputTF.layer.borderColor = UIColor.red.cgColor
        inputTF.layer.borderWidth = 1.0
    }

}
