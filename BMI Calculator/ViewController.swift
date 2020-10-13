//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Muhammad Irfan on 30/07/19.
//  Copyright © 2019 Muhammad Irfan. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weightSlider.minimumValue = 40
        weightSlider.maximumValue = 200
        heightSlider.minimumValue = 1.0
        heightSlider.maximumValue = 2.80
        handleChange()
    }

    
    @IBAction func changeWeightValue(_ sender: UISlider) {
        weight = weightSlider.value
        handleChange()
    }
    
    
    @IBAction func changeHeightValue(_ sender: UISlider) {
        height = heightSlider.value
        handleChange()
    }
    
    func handleChange(){
        weigthLabel.text = "\(weight)"
        heightLabel.text = "\(height)"
        bmi = weight / (height * height)
        bmiLabel.text = "BMI = \(bmi)"
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
    }
}

