import UIKit
import Pastel

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 0.75)
    }
}

extension CGPoint {
    func distance(_ b: CGPoint) -> CGFloat {
        let xDist = self.x - b.x
        let yDist = self.y - b.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
}

extension UIViewController {
    func setupBackgroundGradient() {
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 10.0
        
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 252/255, green: 227/255, blue: 138/255, alpha: 1.0),
                              UIColor(red: 243/255, green: 129/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0),
                              UIColor(red: 245/255, green: 78/255, blue: 162/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        self.view.insertSubview(pastelView, at: 0)
    }
}
