//
//  LoginViewController.swift
//  ParseChatDemo
//
//  Created by Timothy Mak on 12/1/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        if(validUsernameAndPassword()) {
            registerUser()
        }
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        if(validUsernameAndPassword()) {
            loginUser()
        }
    }
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                //print(error.localizedDescription)
                self.signInErrorAlert(error: error)
            }
            else {
                print("User registered successfully")
            }
        }
    }
    
    func loginUser() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                //print(error.localizedDescription)
                self.signInErrorAlert(error: error)
            }
            else {
                print("User logged in successfully")
            }
        }
    }
    
    func validUsernameAndPassword() -> Bool {
        if (usernameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!{
            let alertController = UIAlertController(title: "Username and Password Required", message: "Please enter your username and password", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            present(alertController, animated: true, completion: {})
            
            return false
        }
        else {
            return true
        }
    }
    
    func signInErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Error Occurred", message: error.localizedDescription, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: {})
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
