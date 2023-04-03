//
//  ViewController.swift
//  triviaApp
//
//  Created by Duver on 2/11/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var imageQuestion: UIImageView!
  @IBOutlet weak var textQuestion: UILabel!
  

  @IBOutlet weak var trueeButton: UIButton!
  @IBOutlet weak var falseButton: UIButton!
  @IBOutlet weak var progressBar: UIProgressView!
  
  var brain = Brain()
  var player: AVAudioPlayer!
  
  
//  life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    Buttons Config
    
    trueeButton.layer.cornerRadius = 20
    falseButton.layer.cornerRadius = 20
    trueeButton.backgroundColor = .systemFill
    falseButton.backgroundColor = .systemFill
    trueeButton.tintColor = .white
    
  
//    progressBar config
    
    progressBar.progress = brain.getProgress()
    
//    image config
    imageQuestion.image = brain.getImage()
    imageQuestion.layer.cornerRadius = 20
    imageQuestion.layer.masksToBounds = true
    
//    questions texts config
    
    textQuestion.text = brain.getTextQuestion()
    textQuestion.textColor = brain.getColor()
    
    
    scoreLabel.text = "Score: \(brain.getScore())"
    
    
    
  }
  
  

  @IBAction func usersAnswersTap(_ sender: UIButton) {
    let usersAnswer = sender.titleLabel?.text ?? "True"
    
    let rightAnswer = brain.checkAnswer(userAnswer: usersAnswer)
    
    if rightAnswer {
      sender.backgroundColor = UIColor.green
    }else{
      sender.backgroundColor = UIColor.systemRed
//      user wrong answer
      let generator = UIImpactFeedbackGenerator(style: .heavy)
      generator.impactOccurred()
    }

    falseButton.isEnabled = false
    trueeButton.isEnabled = false
    
//    validate is there is more question
    
    if brain.nextQuestion(){
      let alert = UIAlertController(title: "End of quizz", message: "Do you want try again?", preferredStyle: .alert)
      
      let yesAction = UIAlertAction(title: "Yes", style: .default){_ in
        self.brain.score = 0
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.changeQuestion), userInfo: nil, repeats: false)
        
      }
      let noAction = UIAlertAction(title: "No", style: .cancel){
        _ in exit(0)
      }
      alert.addAction(yesAction)
      alert.addAction(noAction)
      present(alert, animated: true)
    }else{
      Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeQuestion), userInfo: nil, repeats: false)
      
    }
    
  }
  
  @objc func changeQuestion(){
    textQuestion.text = brain.getTextQuestion()
    textQuestion.textColor = brain.getColor()
    
    imageQuestion.image = brain.getImage()
    progressBar.progress = brain.getProgress()
    
    scoreLabel.text = "Score: \(brain.getScore())"
    
    trueeButton.backgroundColor = UIColor.systemFill
    falseButton.backgroundColor = UIColor.systemFill
    
    trueeButton.isEnabled = true
    falseButton.isEnabled = true
    
  }
  
  func celebrateWithClaps(){
    guard let url =  Bundle.main.url(forResource: "clap", withExtension: nil) else{
      return
    }
    
    do{
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try
      AVAudioSession.sharedInstance().setActive(true)
        player = try AVAudioPlayer(contentsOf: url)
      if let player {player.play()}
    }catch{
      
      print("Error: Audio doesn't work \n"
            )
    }
    
    
  }
} // view controller

