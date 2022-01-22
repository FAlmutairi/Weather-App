//
//  ViewController.swift
//  Weather
//
//  Created by Ferasico on 15/01/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewCity: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var weatherManager = WeatherManager()
    let location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.requestLocation()
        
        viewOne.layer.cornerRadius = 20
        viewCity.layer.cornerRadius = 20
        locationButton.layer.cornerRadius = 20
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        
    }
    
    //
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        location.requestLocation()
    }
    
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate{
    
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
// MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let loca = locations.last {
            location.startUpdatingLocation()
            let lat = loca.coordinate.latitude
            let lon = loca.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
