//
//  ViewController.swift
//  Views
//
//  Created by Volodymyr Ostapyshyn on 01.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameFieldView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        timeLabel.text = "Time: \(sender.value) sec"
    }


}

