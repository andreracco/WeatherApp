//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Andre Racco on 6/18/18.
//  Copyright © 2018 Andre Racco. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!

    var weather = WeatherModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        
        cityTextField.isHidden = true
        getButton.isHidden = true
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
        
        cityTextField.isHidden = false
        getButton.isHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    @IBAction func getButtonTapped(_ sender: Any) {
        if cityTextField.text == "" {
            emptyLabels()
            dateLabel.text = "CITY EMPTY"
        } else {
            weather.setURL(city: cityTextField.text!)
            weather.getData {
                self.updateUI()
            }
        }
    }
    
    @IBAction func cityTextFieldChanged(_ sender: Any) {
        if cityTextField.text == "" {
            getButton.isEnabled = true
        } else {
            getButton.isEnabled = false
        }
    }
    
    func emptyLabels() {
        dateLabel.text = ""
        temperatureLabel.text = ""
        locationLabel.text = ""
        weatherLabel.text = ""
        weatherImage.image = nil
    }
    
    func updateUI() {
        dateLabel.text = weather.date
        temperatureLabel.text = weather.temperature
        locationLabel.text = weather.location
        weatherLabel.text = weather.weather
        weatherImage.image = UIImage(named: weather.weather)
    }

}

