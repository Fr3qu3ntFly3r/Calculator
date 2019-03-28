//
//  Calculation.swift
//  Calculator
//
//  Created by Szamódy Zs. Balázs on 2017. 07. 14..
//  Copyright © 2017. Szamódy Zs. Balázs. All rights reserved.
//

import Foundation

class DisplayCalculation: CustomStringConvertible {
    
    var calculation: String?
    var result: String?
    
    var description: String {
        return "\(calculation ?? "nil") \(result ?? "nil")"
    }
    
    static var calculationHistory: [DisplayCalculation] = []
 
    static func addCalculation() {
        calculationHistory.append(DisplayCalculation())
    }
    
    static func updateCalculation(with text: String) {
        let currentCalculation = calculationHistory[calculationHistory.count - 1]
        
        if currentCalculation.calculation != nil {
            
            /*guard currentCalculation.calculation!.contains(" ") || text.contains(" ") else {
                currentCalculation.calculation = text
                return
            }
             */
            currentCalculation.calculation! += text
        } else {
            currentCalculation.calculation = text
        }
    }
    
    static func updateResult(with number: Double) {
        calculationHistory[calculationHistory.count - 1].result = displayResult(number)
    }
    
    
    static func removeLastOperation() {
        if calculationHistory[calculationHistory.count - 1].calculation != nil {
            for _ in 1 ... 3 {
               _ = calculationHistory[calculationHistory.count - 1].calculation!.popLast()
            }
            
        }
    }
    
    static func displayResult(_ result: Double) -> String {
        let rawResult = "\(result)"
        var resultString = ""
        var characters = Array(rawResult)
        while characters[characters.count - 1] == "0" {
            _ = characters.popLast()
        }
        if characters[characters.count - 1] == "." {
            _ = characters.popLast()
        }
        for character in characters {
            resultString += "\(character)"
        }
        
        return resultString
        
    }
    
}
