//
//  ViewController.swift
//  Views
//
//  Created by Volodymyr Ostapyshyn on 01.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameFieldView: GameFieldView! 
    
    
    @IBOutlet var gameControl: GameControlViewClass!
    
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    

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
        
        gameControl.startStopHandler = {
            [weak self] in self?.startTapped()
        }
        gameControl.gameDuration = 20
    }
    
  
    
     func startTapped() {
        if gameControl.isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    func objectTapped() {
        guard gameControl.isGameActive else { return }
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
        
        gameControl.gameTimeLeft = gameControl.gameDuration
        gameControl.isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        gameControl.isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
        scoreLabel.text = "Last count: \(score)"
    }
    
    @objc private func gameTimerTick() {
        gameControl.gameTimeLeft -= 1
        if gameControl.gameTimeLeft <= 0 {
            stopGame()
        } else {
            updateUI()
        }
    }
    
    private func updateUI() {
        gameFieldView.isShapeHidden = !gameControl.isGameActive
        
    }
    
    @objc private func moveImage() {
        gameFieldView.randomizeShapes()
    }
    
    
}

