//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft" : 300,"Medium" : 400, "Hard" : 720]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime=0
    var secondsPassed=1
    
    //var label =
   
    
    @IBOutlet weak var titleOfApp: UILabel!
   
    @IBOutlet weak var progressB: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressB.progress = 0.0
        secondsPassed=0
        titleOfApp.text=hardness


        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] timer in
           
            if secondsPassed <= totalTime {
               let percentageProgress = Float(secondsPassed)/Float( totalTime)
                progressB.progress=(percentageProgress)
                self.secondsPassed += 1
                
            }
           
            else {
                self.titleOfApp.text = "Done"
                timer.invalidate()
                
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                            player = try! AVAudioPlayer(contentsOf: url!)
                            player.play()
            }
        }
       

        
        

    }
    
}
