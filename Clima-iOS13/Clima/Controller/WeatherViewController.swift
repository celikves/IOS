//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var SearchTextField: UITextField!
   
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        SearchTextField.endEditing(true)
        print(SearchTextField.text!)
    }
    // e76409a001a363d93c0f4a3d660704d8

    
    func  textFieldShouldReturn(_ textField : UITextField)->Bool{
        SearchTextField.endEditing(true)
        print(SearchTextField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // use the search textField.text to get the weather for that city
        if let city = SearchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        SearchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else{
            textField.placeholder = "Type something! "
            return false
        }
    }
}

