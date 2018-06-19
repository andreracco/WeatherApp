//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Andre Racco on 6/18/18.
//  Copyright © 2018 Andre Racco. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!

    var weather = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = ""
        temperatureLabel.text = ""
        locationLabel.text = "Loading..."
        weatherLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        weather.getData {
            self.updateUI()
        }
    }

    func updateUI() {
        dateLabel.text = weather.date
        temperatureLabel.text = weather.temperature
        locationLabel.text = weather.location
        weatherLabel.text = weather.weather
        weatherImage.image = UIImage(named: weather.weather)
    }

}

