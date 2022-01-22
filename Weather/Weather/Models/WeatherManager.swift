//
//  WeatherManager.swift
//  Weather
//
//  Created by Ferasico on 17/01/2022.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let WeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ea4d3d92e391810568c780e53587d238&units=metric"
    
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlStrings = "\(WeatherURL)&q=\(cityName)"
        print(urlStrings)
        performRequest(with: urlStrings)
    }
    
    // fetcj
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees ){
        let urlLocation = "\(WeatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlLocation)
    }
    
    
    
    // Connect with server (Create URL Session)
    func performRequest(with urlString: String){
        
        // 1. Create a URL
        if  let url = URL(string: urlString) {
            
            // 2. Create a Session task
            let session = URLSession(configuration: .default)
            
            // 3. Give the session task
            let task = session.dataTask(with: url) { data, response, error in
                
                // Connot contact with server
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                
                // Optional
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
        
    }
    
    
    //
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        
        // use DO-TRY to control error
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            //            print(weather.conditionName)
            //            print(weather.temperatureString)
            
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
}
