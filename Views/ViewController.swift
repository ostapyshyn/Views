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
    @IBOutlet var shapeX: NSLayoutConstraint!
    @IBOutlet var shapeY: NSLayoutConstraint!
    @IBOutlet var gameObject: UIImageView!
    
    
    private var isGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    private var gameTimer: Timer?
    private var timer: Timer?
    private let displayDuration: TimeInterval = 2
    
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
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: displayDuration, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
        timer?.fire()
        
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerTick), userInfo: nil, repeats: true)
        
        gameTimeLeft = stepper.value
        isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
    }
    
    @objc private func gameTimerTick() {
            gameTimeLeft -= 1
            if gameTimeLeft <= 0 {
                stopGame()
            } else {
                updateUI()
            }
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
    
    @objc private func moveImage() {
        let maxX = gameFieldView.bounds.maxX - gameObject.frame.width
        let maxY = gameFieldView.bounds.maxY - gameObject.frame.height
        
        shapeX.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
        shapeY.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
        
        //gameFieldView.randomizeShapes()
    }
    
    
}

