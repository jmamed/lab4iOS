//
//  RPiCommandViewController.swift
//  PianoRobotWithFirebase
//
//  Created by Jason Mamed on 11/23/16.
//  Copyright © 2016 Mamed Technologies. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RPiCommandViewController: UIViewController {

    @IBAction func song1Action(_ sender: Any)
    {
        song(state: "song1")
    }
    @IBAction func song2Action(_ sender: Any)
    {
        song(state: "song2")
    }
    @IBAction func stopsong(_ sender: Any) {
        song(state: "STOP")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //song(state: "ON")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func song(state: String){
        let ref = FIRDatabase.database().reference()
        let post : [String: AnyObject] = ["state": state as AnyObject]
        ref.child("song").setValue(post)
    }

}
