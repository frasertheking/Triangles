import UIKit
import Pastel
import RandomColorSwift

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
    func setupBackgroundGradient(landing: Bool, luminosity: Luminosity) {
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 10.0
        
        var randomColorArray: [UIColor] = [UIColor]()
        
        for _ in 0...20 {
            randomColorArray.append(randomColor(hue: .random, luminosity: luminosity))
        }
        
        pastelView.setColors(randomColorArray)
        
        pastelView.startAnimation()
        self.view.insertSubview(pastelView, at: 0)
    }
    
    func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
