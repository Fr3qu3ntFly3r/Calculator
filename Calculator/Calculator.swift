//
//  Calculator.swift
//  Calculator
//
//  Created by Szamódy Zs. Balázs on 2017. 07. 04..
//  Copyright © 2017. Szamódy Zs. Balázs. All rights reserved.
//

import Foundation

enum MathOperation: String {
    case Plus = " + "
    case Minus = " - "
    case Multiply = " x "
    case Divide = " / "
    case Equal = ""
    case Percent = " % "
    case Negate = " -"
    
    // additional operations: 1/x, x2, Sqr(x), parentheses
}

struct Calculator {
    var firstNumber: Double? = nil
    var secondNumber: Double? = nil
    var operation: MathOperation? = nil 
    
    // Number gets passed as a string
    mutating func getNumber(_ numberString: String) {
        if let number = Double(numberString) {
            if firstNumber == nil {
                firstNumber = number
                
                // create new entry in calculation history
                DisplayCalculation.addCalculation()
                
                
                
            } else {
                secondNumber = number
                
                
                
            }
            
            // pass the next number to calculation history
            DisplayCalculation.updateCalculation(with: numberString)
        }
    }
    
    // passes the operator
    mutating func getOperation(_ pressedOperation: MathOperation) -> Double? {
        var result: Double? = nil
        
        if operation != nil {
            if secondNumber != nil {
                result =  calculate()
                
                if pressedOperation != .Equal {
                    operation = pressedOperation
                    
                    
                } else {
                    firstNumber = nil
                }
                
                
                
            } else {
                if pressedOperation == .Equal {
                    secondNumber = firstNumber
                    
                    // pass the new secondNumber to calculation History
                    DisplayCalculation.updateCalculation(with: "\(secondNumber!)")
                    
                    result = calculate()
                    firstNumber = nil
                } else {
                   operation = pressedOperation
                    
                    // remove the last operation, to be able to replace
                    DisplayCalculation.removeLastOperation()
                }
            }
            
        } else {
            if pressedOperation != .Equal {
               operation = pressedOperation
               
            } else {
                result = firstNumber
                firstNumber = nil
            }
            
            
        }
        
        // update the calculation and result in history
        DisplayCalculation.updateCalculation(with: pressedOperation.rawValue)
        
        if let result = result {
            DisplayCalculation.updateResult(with: result)
        }
        print(DisplayCalculation.calculationHistory)
        return result
    }
    
    // handles the calculation, as a result only firstNumber is not nil
    mutating func calculate() -> Double? {
        if let operation = operation {
            switch operation {
            case .Plus:
                firstNumber = firstNumber! + secondNumber!
                self.operation = nil
                secondNumber = nil
                
            case .Minus:
                firstNumber = firstNumber! - secondNumber!
                self.operation = nil
                secondNumber = nil
            case .Multiply:
                firstNumber = firstNumber! * secondNumber!
                self.operation = nil
                secondNumber = nil
            case .Divide:
                firstNumber = firstNumber! / secondNumber!
                self.operation = nil
                secondNumber = nil
            case .Equal:
                self.operation = nil
            case .Percent:
                
                self.operation = nil
            case .Negate:
                
                self.operation = nil
            }
            
        }
        
       return firstNumber
    }
    
    //Handling the number modifiers
    func calculateModifier(_ numberString: String, _ modifier: MathOperation) -> Double? {
        if let number = Double(numberString){
            if modifier == .Percent {
                return number / 100
            } else if modifier == .Negate {
                return -number
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    
}
