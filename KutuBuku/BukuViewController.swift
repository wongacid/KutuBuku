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
    
    // while typing do this action
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        bookTitleTF.layer.borderColor = UIColor.clear.cgColor
        numberOfPageTF.layer.borderColor = UIColor.clear.cgColor
        return true
    }

}

class BukuViewController: UIViewController {

    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bookTitleTF: UITextField!
    @IBOutlet weak var numberOfPageTF: UITextField!
    @IBOutlet weak var newBookView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disabledSaveButton()
        bookTitleTF.delegate = self
        numberOfPageTF.delegate = self
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeModalView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        if self.bookTitleTF.text!.isEmpty || self.numberOfPageTF!.text!.isEmpty {
            if self.bookTitleTF.text!.isEmpty {
                self.bookTitleTF.layer.masksToBounds = true
                self.bookTitleTF.layer.borderColor = UIColor.red.cgColor
                self.bookTitleTF.layer.borderWidth = 1.0
                
                shakeView(view: newBookView)
            }
            
            if self.numberOfPageTF.text!.isEmpty {
                self.numberOfPageTF.layer.masksToBounds = true
                self.numberOfPageTF.layer.borderColor = UIColor.red.cgColor
                self.numberOfPageTF.layer.borderWidth = 1.0
                        
                shakeView(view: newBookView)
            }
            
        }else {
            dismiss(animated: true, completion: nil)
        }        
    }
    
    // physically shake the view function
    func shakeView(view: UIView) {
        let viewShakeAnimation = CABasicAnimation(keyPath: "position")
        viewShakeAnimation.duration = 0.07
        viewShakeAnimation.repeatCount = 2
        viewShakeAnimation.autoreverses = true
        viewShakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        viewShakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        view.layer.add(viewShakeAnimation, forKey: "position")
    }
    
    func disabledSaveButton() {
        saveButton.isEnabled = false
        saveButton.setTitleColor(UIColor.gray, for: .normal)
        
    }
    
    func enableSaveButton() {
        saveButton.isEnabled = true
        saveButton.setTitleColor(UIColor.systemBlue, for: .normal)
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
