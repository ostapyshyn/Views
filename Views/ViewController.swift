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
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var startButton: UIButton!
    
    
    private var isGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateUI()
        
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        if isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    
    private func startGame() {
        gameTimeLeft = stepper.value
        isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        isGameActive = false
        updateUI()
    }
    
    private func updateUI() {
        stepper.isEnabled = !isGameActive
        if isGameActive {
            timeLabel.text = "Left: \(Int(gameTimeLeft)) sec"
            startButton.setTitle("Stop", for: .normal)
        } else {
            timeLabel.text = "Time: \(Int(stepper.value)) sec"
            startButton.setTitle("Start", for: .normal)
        }
    }
    
    
}

