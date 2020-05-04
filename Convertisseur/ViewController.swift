//
//  ViewController.swift
//  Convertisseur
//
//  Created by Paul Colombier on 04/05/2020.
//  Copyright © 2020 Paul Colombier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ui_inputValueType: UISegmentedControl!
    @IBOutlet weak var ui_inputValueField: UITextField!
    
    @IBOutlet weak var ui_outputMeterLabel: UILabel!
    @IBOutlet weak var ui_outputCentimeterLabel: UILabel!
    @IBOutlet weak var ui_outputInchesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getInputMeterValue() -> Double? {
        let inputMeters:Double?
        
        if let inputString:String = ui_inputValueField.text,
            let inputDouble:Double = Double(inputString.replacingOccurrences(of: ",", with: ".")) {
            switch ui_inputValueType.selectedSegmentIndex {
            case 0: //m
                inputMeters = inputDouble
            case 1: //cm
                inputMeters = UnitLength.centimeters.converter.baseUnitValue(fromValue: inputDouble)
            case 2: //inches
                inputMeters = UnitLength.inches.converter.baseUnitValue(fromValue: inputDouble)
            default:
                inputMeters = nil
            }
        } else {
             inputMeters = nil
        }
        return inputMeters
    }
    
    func convertInputValue() {
        if let inputMeters = getInputMeterValue() {
            ui_outputMeterLabel.text = "\(inputMeters) m"
            ui_outputCentimeterLabel.text = "\(UnitLength.centimeters.converter.value(fromBaseUnitValue: inputMeters)) cm"
            ui_outputInchesLabel.text = "\(UnitLength.inches.converter.value(fromBaseUnitValue: inputMeters)) inches"

        } else {
            ui_outputMeterLabel.text = nil
            ui_outputCentimeterLabel.text = nil
            ui_outputInchesLabel.text = nil
        }
    }

    @IBAction func inputValueTypeChanged() {
        convertInputValue()
    }
    
    @IBAction func inputValueChanged() {
        convertInputValue()
    }
}

