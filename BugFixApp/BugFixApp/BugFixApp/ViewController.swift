//
//  ViewController.swift
//  BugFixApp
//
//  Created by 橋本晄汰 on 2026/10/21.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var numField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var roginBtn: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        selectView.layer.borderWidth = 1
        selectView.layer.cornerRadius = 12
        selectView.layer.borderColor = UIColor.black.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification)
       {
           guard let userInfo = notification.userInfo,
                 let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                 let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
           else { return }
           
           // すでに上げている量
           let currentShift = -view.transform.ty
           
           // selectView の下端(画面座標。現在の移動量も含まれる)
           let bottom = selectView.convert(selectView.bounds, to: nil).maxY
           
           // キーボードに被っている量(余白16pt込み)
           let overlap = bottom + 16 - keyboardFrame.minY
           let newShift = max(0, currentShift + overlap)
           
           UIView.animate(withDuration: duration)
           {
               self.view.transform = CGAffineTransform(translationX: 0, y: -newShift)
           }
       }
       
       @objc private func keyboardWillHide(_ notification: Notification)
       {
           let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25
           UIView.animate(withDuration: duration)
           {
               self.view.transform = .identity
           }
       }
       
       @objc private func dismissKeyboard()
       {
           view.endEditing(true)
       }
    
    @IBAction func roginBtn(_ sender: Any)
    {
        let num = numField.text ?? ""
        let name = nameField.text ?? ""
        
        if num == "1231450" && name == "二島彩子"
        {
            performSegue(withIdentifier: "toProgram", sender: nil)
        }
    }
    
    

}

