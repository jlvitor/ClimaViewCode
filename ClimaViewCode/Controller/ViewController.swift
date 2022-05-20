//
//  ViewController.swift
//  ClimaViewCode
//
//  Created by Jean Lucas Vitor on 02/05/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var screen: WeatherViewScreen?
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    override func loadView() {
        self.screen = WeatherViewScreen()
        self.screen?.configTextFieldDelegate(delegate: self)
        self.screen?.delegate(delegate: self)
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
    }
    
}

//MARK: - WeatherViewScreenProtocol
extension ViewController: WeatherViewScreenProtocol {
    func tappedLocaleBtn() {
        locationManager.requestLocation()
    }
    
    func tappedSearchBtn() {
        self.screen?.searchLabel.endEditing(true)
    }
}

//MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.screen?.temperatureLabel.text = weather.temperatureString
            self.screen?.weatherIcon.image = UIImage(systemName: weather.conditionName)
            self.screen?.cityLabel.text = weather.cityName
        }
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.screen?.searchLabel.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city = self.screen?.searchLabel.text {
            weatherManager.fetchWeather(cityName: city)
        }
        self.screen?.searchLabel.text = ""
    }
}

//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitute: long)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
