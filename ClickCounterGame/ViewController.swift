//
//  ViewController.swift
//  ClickCounterBasic
//
//  Created by Alwin Ventura on 8/7/18.
//  Copyright © 2018 Alwin Ventura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    var label: UILabel!
    var button: UIButton!
    var button2: UIButton!

    weak var timerLabel: UILabel!
    var seconds = 30
    var timer = Timer()
    var isTimeRunning = false


    //random 'increment' and 'decrement' placement
    func moveButton(button: UIButton) {

        // Find the button's width and height
        let buttonWidth = button.frame.width
        let buttonHeight = button.frame.height

        // Find the width and height of the enclosing view
        let viewWidth = button.superview!.bounds.width
        let viewHeight = button.superview!.bounds.height

        // Compute width and height of the area to contain the button's center
        let xwidth = viewWidth - buttonWidth
        let yheight = viewHeight - buttonHeight

        // Generate a random x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))

        // Offset the button's center by the random offsets.
        button.center.x = (xoffset + buttonWidth / 2)
        button.center.y = (yoffset + buttonHeight / 2)
        
        if button.center.x == button.center.y {
            button.center.x = button.center.y + 10
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let timerLabel = UILabel()
        timerLabel.frame = CGRect(x: 150, y: 50, width: 100, height: 60)
        timerLabel.text = "\(timer)"
        view.addSubview(timerLabel)
        self.timerLabel = timerLabel

        //click counter label
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 50, width: 200, height: 60)
        label.text = "Your Score: 0"
        view.addSubview(label)
        self.label = label

        //Display Increment button
        let button = UIButton()
        button.frame = CGRect(x: 150, y: 250, width: 60, height: 60)
        button.setTitle("YES", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(ViewController.incrementCount), for: UIControlEvents.touchUpInside)
        self.button = button


        //Decrement button
        let button2 = UIButton()
        button2.frame = CGRect(x: 150, y: 300, width: 100, height: 60)
        button2.setTitle("NOPE", for: .normal)
        button2.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(button2)
        button2.addTarget(self, action: #selector(ViewController.decrementCount), for: UIControlEvents.touchUpInside)
        self.button2 = button2

    }
    //Increments click number
    @objc func incrementCount() {
        self.count += 1
        self.label.text = "Your Score: \(self.count)"
        moveButton(button: button)
        moveButton(button: button2)
        startTimerTapped()
    }

    //Decrements click number
    @objc func decrementCount() {
        self.count -= 1
        self.label.text = "Your Score: \(self.count)"
        moveButton(button: button)
        moveButton(button: button2)
    }

    func startTimerTapped() {
        if isTimeRunning == false {
            runTimer()
        }
    }

    @objc func updateTimer() {
        if seconds == 0 {
            timerLabel.text = "FINISHED!"
            gameOverState()

        } else {
            seconds -= 1
            timerLabel.text = "time left: \(seconds)"
        }
    }

    func gameOverState() {
        button.setTitleColor(UIColor.white, for: .normal)
        button2.setTitleColor(UIColor.white, for: .normal)
        button.removeTarget(self, action: #selector(ViewController.incrementCount), for: UIControlEvents.touchUpInside)
        button2.removeTarget(self, action: #selector(ViewController.decrementCount), for: UIControlEvents.touchUpInside)

    }

    func runTimer() {
        isTimeRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }


}

