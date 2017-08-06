//
//  LandingViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-08-05.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import Pastel

class LandingViewController: UIViewController {
    
    @IBOutlet weak var logoImageView1: UIImageView!
    @IBOutlet weak var logoImageView2: UIImageView!
    @IBOutlet weak var logoImageView3: UIImageView!
    @IBOutlet weak var logoImageView4: UIImageView!
    @IBOutlet weak var logoImageView5: UIImageView!
    @IBOutlet weak var logoImageView6: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundGradient()
        /*sketchView.devModeEnabled = false
        sketchView.kLineWidth = 2
        sketchView.kTriangleStrokeBufferWidth = 2
        sketchView.kVertexRadius = 4
        
        sketchView.setupLevel(level: Levels.logo)*/
        
        logoImageView2.alpha = 0
        logoImageView3.alpha = 0
        logoImageView4.alpha = 0
        logoImageView5.alpha = 0
        logoImageView6.alpha = 0
        
        animateIn()
    }
    
    func animateIn() {
        animateLogo(view: logoImageView2, alpha: 1.0, duration: 0.25, delay: 5.0, completion: { (finished) in
            self.animateLogo(view: self.logoImageView3, alpha: 1.0, duration: 0.25, delay: 0.75, completion: { (finished) in
                self.animateLogo(view: self.logoImageView4, alpha: 1.0, duration: 0.25, delay: 0.75, completion: { (finished) in
                    self.animateLogo(view: self.logoImageView5, alpha: 1.0, duration: 0.25, delay: 0.75, completion: { (finished) in
                        self.animateLogo(view: self.logoImageView6, alpha: 1.0, duration: 0.25, delay: 0.75, completion: { (finished) in
                            self.animateOut()
                        })
                    })
                })
            })
        })
    }
    
    func animateOut() {
        animateLogo(view: logoImageView6, alpha: 0.0, duration: 0.1, delay: 5.0, completion: { (finished) in
            self.animateLogo(view: self.logoImageView5, alpha: 0.0, duration: 0.1, delay: 0.0, completion: { (finished) in
                self.animateLogo(view: self.logoImageView4, alpha: 0.0, duration: 0.1, delay: 0.0, completion: { (finished) in
                    self.animateLogo(view: self.logoImageView3, alpha: 0.0, duration: 0.1, delay: 0.0, completion: { (finished) in
                        self.animateLogo(view: self.logoImageView2, alpha: 0.0, duration: 0.1, delay: 0.0, completion: { (finished) in
                            self.animateIn()
                        })
                    })
                })
            })
        })
    }
    
    func animateLogo(view: UIView, alpha: CGFloat, duration: TimeInterval, delay: TimeInterval, completion: @escaping (Void) -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            view.alpha = alpha
        }) { (finished) in
            completion()
        }
    }
}
