//
//  ViewController.swift
//  Views
//
//  Created by Volodymyr Ostapyshyn on 01.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameFieldView: GameFieldView! 
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    private var isGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    private var gameTimer: Timer?
    private var timer: Timer?
    private let displayDuration: TimeInterval = 2
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
        updateUI()
        
        gameFieldView.shapeHitHandler = { [weak self] in
            self?.objectTapped()
        }
        
//        gameControl.startStopHandler = { [weak self] in
//            self?.actionButtonTapped()
//        }
//        gameControl.gameDuration = 20
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
    
    func objectTapped() {
        guard isGameActive else { return }
        repositionImageWithTimer()
        score += 1
    }
    
    private func repositionImageWithTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: displayDuration, target: self, selector: #selector(moveImage), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    
    
    private func startGame() {
        score = 0
        repositionImageWithTimer()
        
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
        scoreLabel.text = "Last count: \(score)"
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
        gameFieldView.isShapeHidden = !isGameActive
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
        gameFieldView.randomizeShapes()
    }
    
    
}

