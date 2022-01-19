//
//  WeatherManager.swift
//  Weather
//
//  Created by Ferasico on 17/01/2022.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager{
    let WeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ea4d3d92e391810568c780e53587d238&units=metric"
    
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlStrings = "\(WeatherURL)&q=\(cityName)"
        print(urlStrings)
        performRequest(urlString: urlStrings)
    }
    
    func performRequest(urlString: String){
        
        // 1. Create a URL
        if  let url = URL(string: urlString) {
            
            // 2. Create a Session task
            let session = URLSession(configuration: .default)
            
            // 3. Give the session task
            let task = session.dataTask(with: url) { data, response, error in
                
                // Connot contact with server
                if error != nil {
                    print(error!)
                    return
                }
                
                // Optional
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
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
            print(error)
            return nil
        }
        
    }
    
    
    
}
