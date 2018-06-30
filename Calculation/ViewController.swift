//
//  ViewController.swift
//  Calculation
//
//  Created by Евгений on 24.06.2018.
//  Copyright © 2018 Евгений. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Переменная результата
    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    // Поставили точку или нет
    var dotIsPlaced = false
    // Первый операнд для операций
    var firstOperand: Double = 0
    // Второй операнд для операций
    var secondOperand: Double = 0
    // Операция для двух операндов
    var operationSign: String = ""
    // Текущий ввод пользователя
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        if stillTyping {
            if displayResultLabel.text!.count < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        print(firstOperand)
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperants(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        dotIsPlaced = false
        switch operationSign {
        case "+":
            operateWithTwoOperants {$0 + $1}
        case "-":
            operateWithTwoOperants {$0 - $1}
        case "×":
            operateWithTwoOperants {$0 * $1}
        case "÷":
            operateWithTwoOperants {$0 / $1}
        default:
            break
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlaced = false
        firstOperand = 0
        secondOperand = 0
        operationSign = ""
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
}

