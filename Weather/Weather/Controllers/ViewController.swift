//
//  ViewController.swift
//  Weather
//
//  Created by Ferasico on 15/01/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewCity: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewOne.layer.cornerRadius = 20
        viewCity.layer.cornerRadius = 20
        locationButton.layer.cornerRadius = 20
        
        searchTextField.delegate = self
       
        
    }

    //
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    
    // This function help us to press return button instead of search button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    //
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
            
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    
    // Use searchTexTField.Text. to got the weather for that city.
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        // To clear TextField after press on search button
        searchTextField.text = ""
        
    }
    
    
}

