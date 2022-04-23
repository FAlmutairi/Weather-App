//
//  WeatherDetailsVC.swift
//  Weather
//
//  Created by FERAS on 24/04/2022.
//

import UIKit

class WeatherDetailsVC: UIViewController {

    @IBOutlet weak var detailsInfo: UIView!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempFeel: UILabel!
    @IBOutlet weak var seaLevel: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var windSpeedLable: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var weathericon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailsInfo.layer.cornerRadius = 30
        
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        print("Back")
    }

    

}
