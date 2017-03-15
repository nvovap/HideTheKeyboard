//
//  ViewController.swift
//  HideTheKeyboard
//
//  Created by Vladimir Nevinniy on 3/15/17.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import UIKit
import Kanna

class ViewController: UIViewController {
    
    @IBOutlet weak var buttomTextField: UITextField!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        registerForKeyboardNotifications()
        
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerForKeyboardNotifications()  {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func kbWillShow(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let kbFrameSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
        }
        
        
        
        
    }
    
    func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    
    func displayURL() {
        let myURL = URL(string: "http://www.appcoda.com")
        
        
        
        URLSession.shared.dataTask(with: myURL!) { (myData, response, error) in
            guard error == nil else {
                return
            }
            
            let myHTMLString = String.init(data: myData!, encoding: String.Encoding.utf8)
            
            print(myHTMLString ?? "")
            
            
            if let html = myHTMLString {
               
                
                if let doc = HTML(html: html, encoding: .utf8) {
                    print(doc.title)
                    
                    // Search for nodes by CSS
                    for link in doc.css("a, link") {
                        print(link.text)
                        print(link["href"])
                    }
                    
                    // Search for nodes by XPath
                    for link in doc.xpath("//a | //link") {
                        print(link.text)
                        print(link["href"])
                    }
                }
            }
            
            
        }.resume()
    }
    
    @IBAction func tap(_ sender: Any) {
        topTextField.resignFirstResponder()
        buttomTextField.resignFirstResponder()
        
        displayURL()
        
    }

}

