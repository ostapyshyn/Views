//
//  GameControlViewClass.swift
//  Views
//
//  Created by Volodymyr Ostapyshyn on 09.10.2020.
//

import UIKit

@IBDesignable
class GameControlViewClass: UIView {
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName:  "GameControlView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    
    
}
