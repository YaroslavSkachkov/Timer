//
//  ViewController.swift
//  Timer
//
//  Created by Yaroslav Skachkov on 29.03.2018.
//  Copyright © 2018 Yaroslav Skachkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var workoutAndRestLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetTimerButton: UIButton!
    
    
    var workoutTime: Int!
    var restTime: Int!
    
    var timer = Timer()
    
    
    @IBAction func startTimer(_ sender: Any) {
         
            restTime = restTime + 1
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func resetTimer(_ sender: Any) {
//        if Int(display.text!) == nil {
//            startButton.isEnabled = false
//            stopButton.isEnabled = false
//            resetTimerButton.isEnabled = false
//        } else if Int(display.text!) != nil {
//            timer.invalidate()
//            display.text = text
//            time = Int(display.text!)!
//        }
        timer.invalidate()
        countdownLabel.text = String()
        workoutTime = Int(countdownLabel.text!)!
    }
    
    
    @IBAction func stopTimer(_ sender: Any) {
        timer.invalidate()
    }
    
    
    @objc func action() {
        
        
        if workoutTime > 1 {
              workoutTime = workoutTime - 1
            countdownLabel.text = String(workoutTime)
        } else {
            workoutAndRestLabel.text = "Rest Time"
            restTime = restTime - 1
            countdownLabel.text = String(restTime)
            
            if restTime == 0 {
                timer.invalidate()
                workoutAndRestLabel.text = ""
                countdownLabel.text = "Set time intervals for a new lap"
                startButton.isEnabled = false
                stopButton.isEnabled = false
                resetTimerButton.isEnabled = false
            }
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let timeToDisplay = workoutTime {
            countdownLabel.text = String(timeToDisplay)
            workoutAndRestLabel.text = "Workout Time"
        }
        
        if Int(countdownLabel.text!) == nil {
            startButton.isEnabled = false
            stopButton.isEnabled = false
            resetTimerButton.isEnabled = false
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

