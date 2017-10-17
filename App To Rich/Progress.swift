//
//  Progress.swift
//  ProgressView
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 Brainilission. All rights reserved.
//

import UIKit

class Progress: UIView {

    // MARK: - Initializers

    var stopAnimatingKey : Bool = false
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var middleViewConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var fourthViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourthView: UIView!
    
    
    @IBOutlet weak var secondViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var secontView: UIView!
    
    @IBOutlet weak var fiveViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var fiveView: UIView!
    
    @IBOutlet weak var firstViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstView: UIView!
    
    override init(frame: CGRect) {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let customFrame = CGRect(x: (screenWidth - (screenWidth * 0.3)) - 15 , y: (screenHeight - screenWidth * 0.15) - 80 , width: screenWidth * 0.3, height: screenWidth * 0.15)
        super.init(frame: customFrame)
        stopAnimatingKey = false

        setupView()
        self.animatingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        self.animatingView()
    }
    
    
    
    override func layoutSubviews() {
        
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.dropShadow()
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        // Show the view.
        addSubview(view)
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }

    private func animatingView(){
        
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.middleViewConstraint = self.middleViewConstraint.setMultiplier(multiplier: CGFloat(0.2))
            let when = DispatchTime.now() + 0.1 
            DispatchQueue.main.asyncAfter(deadline: when) {
                UIView.animate(withDuration: 0.5, animations: {
                self.fourthViewConstraint = self.fourthViewConstraint.setMultiplier(multiplier: CGFloat(0.2))
                self.secondViewConstraint = self.secondViewConstraint.setMultiplier(multiplier: CGFloat(0.2))
                self.layoutIfNeeded()
                })
                
            }
            let whenTwo = DispatchTime.now() + 0.2
            DispatchQueue.main.asyncAfter(deadline: whenTwo) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.firstViewConstraint = self.firstViewConstraint.setMultiplier(multiplier: CGFloat(0.2))
                    self.fiveViewConstraint = self.fiveViewConstraint.setMultiplier(multiplier: CGFloat(0.2))
                    self.layoutIfNeeded()
                })
                
            }
            
            self.layoutIfNeeded()
            
        }){ (success) in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.middleViewConstraint = self.middleViewConstraint.setMultiplier(multiplier: CGFloat(0.8))
                let when = DispatchTime.now() + 0.1
                DispatchQueue.main.asyncAfter(deadline: when) {
                        UIView.animate(withDuration: 0.5, animations: {
                            self.fourthViewConstraint = self.fourthViewConstraint.setMultiplier(multiplier: CGFloat(0.8))
                            self.secondViewConstraint = self.secondViewConstraint.setMultiplier(multiplier: CGFloat(0.8))
                            self.layoutIfNeeded()
                        })
                }
                let whenTwo = DispatchTime.now() + 0.2
                DispatchQueue.main.asyncAfter(deadline: whenTwo) {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.firstViewConstraint = self.firstViewConstraint.setMultiplier(multiplier: CGFloat(0.8))
                        self.fiveViewConstraint = self.fiveViewConstraint.setMultiplier(multiplier: CGFloat(0.8))
                        self.layoutIfNeeded()
                    })
                    
                }
                
                self.layoutIfNeeded()
            }) { (success) in
                if !self.stopAnimatingKey{
                self.animatingView()
                }
                else{
                
                }
            }
            
        }
        
    }
    
}

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: self.firstItem,
            attribute: self.firstAttribute,
            relatedBy: self.relation,
            toItem: self.secondItem,
            attribute: self.secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        newConstraint.isActive = true
        
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

extension UIView {
    
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
}
