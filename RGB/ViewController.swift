//
//  ViewController.swift
//  RGB
//
//  Created by Nils Fischer on 08.03.15.
//  Copyright (c) 2015 Nils Fischer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redTextfield: UITextField!
    @IBOutlet weak var greenTextfield: UITextField!
    @IBOutlet weak var blueTextfield: UITextField!
    
    lazy var rgbNumberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.allowsFloats = false
        formatter.minimum = 0
        formatter.maximum = 255
        return formatter
    }()
    

    var randomTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellowColor()
    }
    
    
    @IBAction func showColorButtonPressed(sender: UIButton) {
        let red = rgbNumberFormatter.numberFromString(redTextfield.text)?.integerValue
        let green = rgbNumberFormatter.numberFromString(greenTextfield.text)?.integerValue
        let blue = rgbNumberFormatter.numberFromString(blueTextfield.text)?.integerValue
        if let red = red {
            if let green = green {
                if let blue = blue {
                    let color = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
                    self.view.backgroundColor = color
                }
            }
        }
    }
    
    @IBAction func randomButtonPressed(sender: UIButton) {
        let red = Int(arc4random_uniform(256))
        let green = Int(arc4random_uniform(256))
        let blue = Int(arc4random_uniform(256))
        redTextfield.text = rgbNumberFormatter.stringFromNumber(NSNumber(integer: red))
        greenTextfield.text = rgbNumberFormatter.stringFromNumber(NSNumber(integer: green))
        blueTextfield.text = rgbNumberFormatter.stringFromNumber(NSNumber(integer: blue))
        let color = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
        self.view.backgroundColor = color
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        if sender.on {
            self.randomTimer = NSTimer.scheduledTimerWithTimeInterval(0.15, target: self, selector: "randomButtonPressed:", userInfo: nil, repeats: true)
        } else {
            self.randomTimer?.invalidate()
            self.randomTimer = nil
        }
    }

}

