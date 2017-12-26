//
//  ViewController.swift
//  RetroCalculator
//
//  Created by AMIT NARAYAN on 2/6/17.
//  Copyright © 2017 NarayanProduction. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var Outputlbl: UILabel!
    
   
   
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
        
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftvarStr = ""
    var rightvarStr = ""
    var result = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        Outputlbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddingPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        
        processOperation(operation: currentOperation)
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        playSound()
        
        runningNumber.removeAll()
        Outputlbl.text = "0"
        currentOperation = Operation.Empty
    }
    
   
    
    func playSound() {
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    
    }
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
               rightvarStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    
                    result = "\(Double(leftvarStr)! * Double(rightvarStr)!)"
                    
                } else if currentOperation == Operation.Divide {
                    
                     result = "\(Double(leftvarStr)! / Double(rightvarStr)!)"
                    
                    
                } else if currentOperation == Operation.Subtract {
                    
                     result = "\(Double(leftvarStr)! - Double(rightvarStr)!)"
                    
                } else if currentOperation == Operation.Add {
                   
                     result = "\(Double(leftvarStr)! + Double(rightvarStr)!)"
                    
                }
            
            leftvarStr = result
            Outputlbl.text = result
            
            }
       currentOperation = operation
        
        } else {
            leftvarStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    
        
    }
}

