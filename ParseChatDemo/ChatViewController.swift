//
//  ChatViewController.swift
//  ParseChatDemo
//
//  Created by Timothy Mak on 12/3/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(_ sender: UIButton) {
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatTextField.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if(success) {
                print("The message was saved!")
                self.chatTextField.text = ""
            }
            else {
                print("Problem saving message: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
