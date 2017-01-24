//
//  HomeViewController.swift
//  PianoRobotWithFirebase
//
//  Created by Jason Mamed on 11/23/16.
//  Copyright © 2016 Mamed Technologies. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import LocalAuthentication

class ViewController: UIViewController, UITextFieldDelegate {

    var AppUsername = "Jason"
    var AppPassword = "1234"
    
    var username = ""
    var password = ""
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    
    @IBAction func ledtest(_ sender: Any)
    {
        led(state: "ON")
    }
    
    @IBAction func ledtestoff(_ sender: Any)
    {
        led(state: "OFF")
    }
    @IBAction func submitLogin(_ sender: Any)
    {
        if (userField.text != "")
        {
            username = userField.text!
            password = passField.text!
            
            if username == AppUsername && password == AppPassword
            {
                performSegue(withIdentifier: "segue1", sender: self)
                print("Successful Login!")
            }
        }
        
        let context:LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need your TouchID", reply: {(wasSuccessful, error) in
                if wasSuccessful {
                    print("WAS A SUCCESS")
                    self.performSegue(withIdentifier: "segue1", sender: self)
                }
                else
                {
                    print("NOT LOGGED IN")
                }
            })
        }
        else
        {
            print("Login Error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //led(state: "ON")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func FirebaseUsername(state: String){
        let ref = FIRDatabase.database().reference()
        let post : [String: AnyObject] = ["state": state as AnyObject]
        ref.child("username").setValue(post)
    }
    
    func FirebasePassword(state: String){
        let ref = FIRDatabase.database().reference()
        let post : [String: AnyObject] = ["state": state as AnyObject]
        ref.child("password").setValue(post)
    }
    
    func led(state: String){
        let ref = FIRDatabase.database().reference()
        let post : [String: AnyObject] = ["state": state as AnyObject]
        ref.child("led").setValue(post)
    }
    
    //Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Presses Return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }


}

