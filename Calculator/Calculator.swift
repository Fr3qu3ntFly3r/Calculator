//
//  Calculator.swift
//  Calculator
//
//  Created by Szamódy Zs. Balázs on 2017. 07. 04..
//  Copyright © 2017. Szamódy Zs. Balázs. All rights reserved.
//

import Foundation

enum MathOperation {
    case Plus
    case Minus
    case Multiply
    case Divide
    case Equal
    case Percent
    case Negate
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
                
            } else {
                secondNumber = number
                
            }
        }
    }
    
    // passes the operator
    mutating func getOperation(_ pressedOperation: MathOperation) -> Double? {
        var result: Double? = nil
        
        if operation != nil {
            if secondNumber != nil {
                result =  calculate()
                firstNumber = nil
                if pressedOperation != .Equal {
                    operation = pressedOperation
                }
                
            } else {
                if pressedOperation == .Equal {
                    secondNumber = firstNumber
                    result = calculate()
                    firstNumber = nil
                } else {
                   operation = pressedOperation
                }
            }
            
        } else {
            if pressedOperation != .Equal {
               operation = pressedOperation
            }
            
            
        }
        
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
