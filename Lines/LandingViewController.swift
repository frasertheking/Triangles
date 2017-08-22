//
//  LandingViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-08-05.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import Pastel
import Hero

class LandingViewController: UIViewController {
    
    @IBOutlet weak var logoContainer: UIView!
    @IBOutlet weak var logoImageView1: UIImageView!
    @IBOutlet weak var logoImageView2: UIImageView!
    @IBOutlet weak var logoImageView3: UIImageView!
    @IBOutlet weak var logoImageView4: UIImageView!
    @IBOutlet weak var logoImageView5: UIImageView!
    @IBOutlet weak var logoImageView6: UIImageView!
    @IBOutlet weak var playButtonImage: UIView!
    @IBOutlet weak var createButtonImage: UIView!
    @IBOutlet weak var helpButtonImage: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sandboxButton: UIButton!
    @IBOutlet weak var instructionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundGradient(luminosity: .bright)
        
        logoImageView2.alpha = 0
        logoImageView3.alpha = 0
        logoImageView4.alpha = 0
        logoImageView5.alpha = 0
        logoImageView6.alpha = 0
        
        playButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playPressed)))
        createButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createPressed)))
        helpButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(instructionsPressed)))

        animateIn()
    }
    
    func animateIn() {
        animateLogo(view: logoImageView2, alpha: 1.0, duration: 0.25, delay: 3.0, completion: { (finished) in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showCreate") {
            let vc = segue.destination as! GameViewController
            vc.isCreateMode = true
        }
    }
    
    @IBAction func playPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "showModes", sender: self)
    }
    
    @IBAction func createPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "showCreate", sender: self)
    }
    
    @IBAction func instructionsPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "showHelp", sender: self)
    }
}
