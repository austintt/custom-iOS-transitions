//: [Previous](@previous)

import UIKit
import PlaygroundSupport

// MARK: Boring setup
let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
containerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

func makeShape(color: UIColor, x: Int, y: Int, radius: CGFloat = 0) -> UIView{
    let circle = UIView(frame:  CGRect(x: x, y: y, width: 50, height: 50))
    circle.layer.cornerRadius = radius
    circle.backgroundColor = color
    return circle
}

let greenCircle = makeShape(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), x: 20, y: 20, radius: 25)
let blueSquare = makeShape(color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), x: 20, y: 100)
let pinkSquare = makeShape(color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), x: 20, y: 180)
let redSquare = makeShape(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), x: 20, y: 260)
let purpleCircle = makeShape(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), x: 20, y: 340, radius: 25)

containerView.addSubview(greenCircle)
containerView.addSubview(blueSquare)
containerView.addSubview(redSquare)
containerView.addSubview(pinkSquare)
containerView.addSubview(purpleCircle)

// MARK: Animations!
UIView.animate(withDuration: 1, delay: 0.5, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
    
    /***
     * Translate
     * Animating the movement of X and Y positions. Used for sliding,
     * bouncing, shaking, etc.
     ***/
    greenCircle.frame.origin.x = containerView.frame.width - 70
    
    /***
     * Rotate
     * Animating the angle of an object
     ***/
    blueSquare.transform = blueSquare.transform.rotated(by: CGFloat(Double.pi / 2))
    
    /***
     * Scale
     * Animating size of an object. Zooming in and out.
     ***/
    pinkSquare.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    
    
    // Combination of animations
    redSquare.frame.origin.x = containerView.frame.width - 70
    redSquare.transform = blueSquare.transform.rotated(by: CGFloat(Double.pi / 2))
    
    purpleCircle.frame.origin.x = containerView.frame.width - 70
    purpleCircle.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    
},  completion: nil)



// Display the containerView
PlaygroundPage.current.liveView = containerView

