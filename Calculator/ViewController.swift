//
//  ViewController.swift
//  Calculator
//
//  Created by Szamódy Zs. Balázs on 2017. 07. 04..
//  Copyright © 2017. Szamódy Zs. Balázs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    
    var isNumberFinished = true
    var isResultNumber = true
    
    var calculator = Calculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: Additional Buttons
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        if isNumberFinished {
            resultLabel.text = "0"
            calculator.firstNumber = nil
            calculator.secondNumber = nil
            calculator.operation = nil
            isNumberFinished = true
            isResultNumber = true
            
        } else {
            if var resultText = resultLabel.text {
                if resultText.characters.count > 1 {
                    resultText.characters.popLast()
                    resultLabel.text = resultText
                    
                } else {
                    resultLabel.text = "0"
                    isNumberFinished = true
                    isResultNumber = true
                    
                }
            }
        }
    }

    @IBAction func negativeButtonPressed(_ sender: UIButton) {
        guard let numberString = resultLabel.text else {
            return
        }
        guard let result = calculator.calculateModifier(numberString, .Negate) else {
            return
        }
        resultLabel.text = displayResult(result)
        isResultNumber = true
        isNumberFinished = true
    }

    @IBAction func percentButtonPressed(_ sender: UIButton) {
        
        guard let numberString = resultLabel.text else{
            return
        }
        
        guard let result = calculator.calculateModifier(numberString, .Percent) else {
            return
        }
        resultLabel.text = displayResult(result)
        isResultNumber = true
        isNumberFinished = true
    }
    
    
    
    //MARK: Operations
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        passOperator(.Equal)
        
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        passOperator(.Plus)
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        passOperator(.Minus)
    }
    
    @IBAction func multiplyButtonPressed(_ sender: UIButton) {
        passOperator(.Multiply)
    }
    
    @IBAction func divideButtonPressed(_ sender: UIButton) {
        passOperator(.Divide)
    }
    
    
    
    //MARK: Numbers
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        buildNumber(with: sender.title(for: .normal)!)
    }
    
        
    @IBAction func commaButtonPressed(_ sender: UIButton) {
        if isNumberFinished {
            buildNumber(with: "0.")
        } else {
            if let numberString = resultLabel.text {
                guard !numberString.characters.contains(".") else {
                    return
                }
                buildNumber(with: ".")
            }
        }
    }
    
    
    //MARK: Helper functions
    func buildNumber(with digit: String) {
        
        if isNumberFinished {
            resultLabel.text = digit
            isNumberFinished = false
            isResultNumber = false
        } else {
            if let currentDigits = resultLabel.text {
                resultLabel.text = currentDigits + digit
            }
        }
        
    }
    
    
    func passOperator(_ operation: MathOperation) {
        
        // passing the math operator to the calculator, and getting back the result
        
        
        if !isNumberFinished || isResultNumber {
            calculator.getNumber(resultLabel.text != nil ? resultLabel.text! : "0")
            isResultNumber = false
        }
        
        let result = calculator.getOperation(operation)
        isNumberFinished = true
        if let result = result {
            
            resultLabel.text = displayResult(result)
            if resultLabel.text == "inf" {
                resultLabel.text = "Error"
            }
            isResultNumber = true
            
        }
        
    }
    
    // removes unnecessary 0-s and . from the end after Double -> String conversion
    func displayResult(_ result: Double) -> String {
        let rawResult = "\(result)"
        var resultString = ""
        var characters = Array(rawResult.characters)
        while characters[characters.count - 1] == "0" {
            characters.popLast()
        }
        if characters[characters.count - 1] == "." {
            characters.popLast()
        }
        for character in characters {
            resultString += "\(character)"
        }
        
        return resultString
        
    }
    
    
}

