//
//  ViewController.swift
//  Calculator
//
//  Created by Yogesh Makwana on 2019-05-14.
//  Copyright © 2019 Yogesh Makwana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: class properies
    var calculations = Calculations()
    var readyToClearDisplay = false
    //MARK: Outlets
    @IBOutlet weak var numberDisplayLabel: UILabel!
    
    @IBOutlet var allButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TODO: change label background
        
        //FIXME: allow decimal numbers
        
        numberDisplayLabel.layer.borderWidth = 1
       
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        print("button pressed")
        let buttonValue = sender.currentTitle!
        print (buttonValue )
        
        var currentLabelValue = numberDisplayLabel.text!
        if (currentLabelValue == "0") {
            currentLabelValue = ""
        }
        
        switch buttonValue {
        case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
            if(!readyToClearDisplay){
                 currentLabelValue = currentLabelValue + buttonValue
            }
            else{
                currentLabelValue = buttonValue
                readyToClearDisplay = false
            }
        case".":
            if(!currentLabelValue.contains(".")){
                currentLabelValue = currentLabelValue + buttonValue
            }
        case "+", "-", "x","/" :
            if(calculations.firstNumber != nil){
                
                calculations.secondNumber = Double(currentLabelValue)
                if let result = calculations.calculateResult(){
                    currentLabelValue = String(format: "%g", result)
                    calculations.firstNumber = result
                    calculations.operation = buttonValue
                    calculations.secondNumber = nil
                    
                }else{
                    currentLabelValue = "Error"
                }
                readyToClearDisplay = true
            }
            else{
                calculations.firstNumber = Double(currentLabelValue)
                calculations.operation = buttonValue
                readyToClearDisplay = true
            }
            
        case "=" :
            calculations.secondNumber = Double(currentLabelValue)
            if let result = calculations.calculateResult(){
                currentLabelValue = String(format: "%g", result)
            }
            else{
                currentLabelValue = "Error"
            }
            calculations.reset()
            readyToClearDisplay = true
            
        case "C" :
            currentLabelValue = "0"
            calculations.reset()
            readyToClearDisplay = false
        default:
            break
        }
        
        numberDisplayLabel.text = currentLabelValue
    }
    
}

