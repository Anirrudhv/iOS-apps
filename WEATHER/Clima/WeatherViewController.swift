

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate{
    
 
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    

  
    let locationManager = CLLocationManager()
    let weatherdatamodel = WeatherDataModel()
    

    
   
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    
   
    func getweatherdata(url: String, parameters:[String:String]){
        Alamofire.request(url, method:.get, parameters:parameters).responseJSON{
            response in
            if response.result.isSuccess{
                print("Got the data")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                
                
            }
            else{
                print("Error \(response.result.error)")
                self.cityLabel.text = "Retry"
            }
        }
    
    }
    

    
    
    
    
    
    func updateWeatherData(json :JSON)
    {
        if let tempResult = json["main"]["temp"].double{
        weatherdatamodel.temperature = Int(tempResult - 273.15)
        
        weatherdatamodel.city = json["name"].stringValue
        weatherdatamodel.condition = json["weather"]["0"]["id"].intValue
        weatherdatamodel.weatherIconName = weatherdatamodel.updateWeatherIcon(condition: weatherdatamodel.condition)
        updateUIwithweather()
        }
            
        else {
            self.cityLabel.text = "N/A"
        }
    
    }
    
    
    
    func updateUIwithweather(){
        cityLabel.text = weatherdatamodel.city
        temperatureLabel.text = "\(weatherdatamodel.temperature)°"
        weatherIcon.image = UIImage(named: weatherdatamodel.weatherIconName)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        print ("longitude = \(location.coordinate.longitude), lattitude = \(location.coordinate.latitude)")
        
            let arr : [String:String] = ["lat" : latitude, "lon" : longitude , "appid" : APP_ID]
            getweatherdata(url: WEATHER_URL, parameters : arr)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Not available"
        
    }
    
    
    


    func userEnteredNewCityName(city: String) {
        let params :[String : String] = ["q" :city , "appid" : APP_ID]
        
        getweatherdata(url: WEATHER_URL, parameters: params)
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
        }
    }
    
    
    
}



