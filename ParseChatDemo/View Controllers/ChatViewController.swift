//
//  ChatViewController.swift
//  ParseChatDemo
//
//  Created by Timothy Mak on 12/3/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getMessages), userInfo: nil, repeats: true)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        let message = self.messages[indexPath.row]
        
        cell.messageLabel.text = message["text"] as? String
        return cell
    }
    
    @objc func getMessages() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) messages.")
                
                if let objects = objects {
                    self.messages = objects
                    self.tableView.reloadData()
                }
            }
            else {
                print("Error fetching messages")
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
