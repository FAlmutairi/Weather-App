//
//  ViewController.swift
//  Weather
//
//  Created by Ferasico on 15/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewCity: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewOne.layer.cornerRadius = 20
        viewCity.layer.cornerRadius = 20
        locationButton.layer.cornerRadius = 20
        
    }


}

