//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Andre Racco on 6/18/18.
//  Copyright © 2018 Andre Racco. All rights reserved.
//

import Foundation
import Alamofire

class WeatherModel {
    
    private var _date: Double?
    private var _temperature: String?
    private var _location: String?
    private var _weather: String?
    typealias JSONStandard = Dictionary<String, AnyObject>
    
    var url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Chicago&appid=365aca34b5c4ea637e3c5ce5b50627d1")!
    
    var date: String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: _date!)
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return (_date != nil) ? "Today - \(dateFormatter.string(from: date))" : "Invalid Date"
    }
    
    var temperature: String {
        return _temperature ?? "0 ºC"
    }
    
    var location: String {
        return _location ?? "Invalid Location"
    }
    
    var weather: String {
        return _weather ?? "Invalid Weather"
    }
    
    func setURL(city: String) {
        url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=365aca34b5c4ea637e3c5ce5b50627d1")!
    }
    
    func getData(completed: @escaping() -> ()) {
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            let result = response.result
            print(result)
            let dictResult = result.value as! JSONStandard
    
            print(dictResult.count)
            if dictResult.count == 2 {
                print(String(describing: dictResult["cod"]))
                self._date = Date().timeIntervalSince1970
                self._location = "CITY NOT FOUND"
                self._weather = ""
                self._temperature = ""
                completed()
                return
            }
            
            let main = dictResult["main"] as! JSONStandard
            let temperature = main["temp"] as! Double
            let weatherArray = dictResult["weather"] as! [JSONStandard]
            
            let weather = weatherArray[0]["main"] as! String

                let name = dictResult["name"] as! String
                let sys = dictResult["sys"] as! JSONStandard
            let country = sys["country"] as! String
                let dt = dictResult["dt"] as! Double
    
                
            self._temperature = String(format: "%.0f° C", temperature - 273.15)
                self._location = "\(name), \(country)"
                self._weather = weather
                self._date = dt
            
            completed()
        })
    }
}
