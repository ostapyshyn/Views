//
//  GameControlViewClass.swift
//  Views
//
//  Created by Volodymyr Ostapyshyn on 09.10.2020.
//

import UIKit

@IBDesignable
class GameControlViewClass: UIView {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var startButton: UIButton!
    
    
    
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        }
        set {
            stepper.value = newValue
            updateUI()
        }
    }
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var isGameActive: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    var startStopHandler: (() -> Void)?
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateUI()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        startStopHandler?()
    }
    
    
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName:  "GameControlView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
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
