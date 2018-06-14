//
//  ViewController.swift
//  calculator
//
//  Created by Anirudh V on 6/12/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit

enum Operation:String{
    case Add = "+"
    case Subtract = "-"
    case Multiply = "*"
    case Divide = "/"
    case null = "null"
}

class ViewController: UIViewController {
    var number = ""
    var leftvalue = ""
    var rightvalue = ""
    var result = ""
    var currentoperation:Operation = .null
    var dotcount:Int = 0

    @IBOutlet weak var display: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        display.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numbers(_ sender: UIButton) {
        if number.count <= 9{
     number += "\(sender.tag)"
     display.text = number
        }}
    
    @IBAction func Clear(_ sender: UIButton) {
            number = ""
            leftvalue = ""
            rightvalue = ""
            result = "0"
            currentoperation = .null
            display.text = "0"
            dotcount = 0
        
    }
    @IBAction func Divide(_ sender: UIButton) {
        operation(operation: .Divide)
    }
    @IBAction func mul(_ sender: UIButton) {
        operation(operation: .Multiply)
    }
    @IBAction func add(_ sender: UIButton) {
        operation(operation: .Subtract)
    }
    
    @IBAction func addition(_ sender: Any) {
        operation(operation: .Add)
    }
    @IBAction func equals(_ sender: Any) {
        operation(operation: currentoperation)
    }
    
    @IBAction func dot(_ sender: Any) {
        if dotcount == 0{
        if number.count <= 8{
        number += "."
        display.text = number
            dotcount+=1
            }}}
    
    func operation(operation:Operation){
        if currentoperation != .null{
        if number != ""
        {  rightvalue = number
            number = ""
        if currentoperation == .Subtract{
            result = "\(Double(leftvalue)! - Double(rightvalue)!)"
            
        }
        else if currentoperation == .Add{
            result = "\(Double(leftvalue)! + Double(rightvalue)!)"
        }
        else if currentoperation == .Multiply{
            result = "\(Double(leftvalue)! * Double(rightvalue)!)"
        }
        else if currentoperation == .Divide{
            result = "\(Double(leftvalue)! / Double(rightvalue)!)"
        }
        leftvalue = result
        if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
            result = "\(Int(Double(result)!))"
        }
        else if(Double(result)!.truncatingRemainder(dividingBy: 1) != 0){
            var ro = round(Double(result)!*1000000)/1000000
            result = "\(ro)"
            
            }
            
        display.text = result
        
    }
            currentoperation = operation }
        else {
            leftvalue = number
            number = ""
            currentoperation = operation
        }
    }
}
