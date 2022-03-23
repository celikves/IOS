//
//  WeatherManagerr.swift
//  Clima
//
//  Created by vesile çelik on 22.11.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e76409a001a363d93c0f4a3d660704d8&units=metric"
    
    func fetchWeather(cityName: String)  {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String){
        //1. Create a URL
        
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session task
            
            let task = session.dataTask(with: url) { data , response ,  error  in
                if error != nil {
                    print(error!)
                    return
                }
                
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
             
            }
            //4. Start the task
            
            task.resume()
        }
        
        
    }
    
    func parseJSON(weatherData : Data ) {
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
        }catch {
            print(error)
        }
        
            
    }

    func handler(data : Data?,responseUrl : URLResponse?, error : Error?) {
        
    }
}
