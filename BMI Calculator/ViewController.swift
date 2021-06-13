//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Muhammad Irfan on 30/07/19.
//  Copyright © 2019 Muhammad Irfan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weigthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var height: Float = 1.74
    var weight: Float = 77.0
    var bmi: Float = 0
    var status: String = ""
    var statusColor: UIColor = UIColor.gray
    
    let speechPlayer = SpeechPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weightSlider.minimumValue = 40
        weightSlider.maximumValue = 200
        heightSlider.minimumValue = 1.0
        heightSlider.maximumValue = 2.80
        handleChange()
        
        accessibilityHandling()
        
    }

    
    @IBAction func changeWeightValue(_ sender: UISlider) {
        weight = weightSlider.value
        speechPlayer.say("weight change to \(weight)")
        handleChange()
    }
    
    
    @IBAction func changeHeightValue(_ sender: UISlider) {
        height = heightSlider.value
        speechPlayer.say("weight change to \(height)")
        handleChange()
    }
    
    func handleChange(){
        weigthLabel.text = "\(weight.round(to: 2))"
        heightLabel.text = "\(height.round(to: 2))"
        bmi = weight / (height * height)
        bmiLabel.text = "BMI = \(bmi.round(to: 2))"
        changeStatus()
        categoryLabel.text = "\(status)"
        categoryLabel.backgroundColor = statusColor
    }
    
    func changeStatus(){
        switch bmi {
        case 0...18.5:
            status = "Underweight"
            statusColor = UIColor.gray
        case 18.5..<25:
            status = "Healthy"
            statusColor = UIColor.green
        case 25..<30:
            status = "Overweight"
            statusColor = UIColor.yellow
        case 30..<35:
            status = "Severely Overweight"
            statusColor = UIColor.orange
        default:
            status = "Morbidly Overweight"
            statusColor = UIColor.red
        }
        
        accessibilityHandling()
    }
    
    func accessibilityHandling(){
        weightSlider.isAccessibilityElement = true
        heightSlider.isAccessibilityElement = true
        weigthLabel.isAccessibilityElement = true
        heightLabel.isAccessibilityElement = true
        bmiLabel.isAccessibilityElement = true
        categoryLabel.isAccessibilityElement = true
        
        weightSlider.accessibilityValue = "Slider for your Weight Value, Right now is \(weight) Kilogram"
        weightSlider.accessibilityTraits = .none
        heightSlider.accessibilityValue = "Slider for your Height Value, Right now is \(height) Meter"
        heightSlider.accessibilityTraits = .none
        
        weigthLabel.accessibilityLabel = "Its \(weight.round(to: 2)) Kilogram"
        heightLabel.accessibilityLabel = "Its \(height.round(to: 2)) Meter"
        
    }
}

extension Float {
    func round(to places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

class SpeechPlayer{
    
    let synthesizer  = AVSpeechSynthesizer()
    
    func say(_ phrase:String){
        
        if UIAccessibility.isVoiceOverRunning{
            let utterence = AVSpeechUtterance(string: phrase)
            utterence.voice = AVSpeechSynthesisVoice(language: "en-EN")
            synthesizer.speak(utterence)
        }
        
    }
    
}
