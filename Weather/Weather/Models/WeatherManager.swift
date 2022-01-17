//
//  WeatherManager.swift
//  Weather
//
//  Created by Ferasico on 17/01/2022.
//

import Foundation

struct WeatherManager {
    let WeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ea4d3d92e391810568c780e53587d238&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(WeatherURL)&q=\(cityName)"
        print(urlString)
    }
    
    func performRequest(urlString: String){
        
        // 1. Create a URL
        if  let url = URL(string: urlString) {
            
            // 2. Create a Session task
            let session = URLSession(configuration: .default)
            
            // 3. Give the session task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            // 4. Start the task
            task.resume()
        }
  
    }
    
    
    
    func handle(data: Data?, response: URLResponse?, error: Error? ) {
        
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
