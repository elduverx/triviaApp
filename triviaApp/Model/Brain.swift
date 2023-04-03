//
//  Brain.swift
//  triviaApp
//
//  Created by Duver on 2/11/22.
//

import Foundation
import UIKit

struct Brain {
  let questions = [
    Question(text: "Tokio is the capital of Japan?", answer: "True", color: .white, image: UIImage(named: "japan")!),
    Question(text: "1 + 1 = 3?", answer: "False", color: .white, image: UIImage(named: "tonto")!),
    Question(text: "Todas Mienten", answer: "True", color: .white, image: UIImage(named: "miente")!),
  ]
  
//  variable Preguntas y Score
  var numQuestion = 0
  var score = 0
  // QUESTION AND ANSWER LOGIC
 mutating func checkAnswer(userAnswer:String) -> Bool{
    if userAnswer == questions[numQuestion].answer{
      score += 1
      return true
    }else{
      return false
    }
  }
  
 mutating func nextQuestion() -> Bool {
    if numQuestion + 1 < questions.count{
      numQuestion += 1
      return false
    }else{
      numQuestion = 0
      return true
    }
  }
  
//  USER HAS GOOD SCORE
  
  func hasUserGoodScore() -> Bool{
    let goodScore = Float(questions.count) * 5  * 0.7
    
//    if Float(score)  >= goodScore{
//      return true
//    }else{
//      return false
//    }
    return Float(score) >= goodScore ? true : false
    
  }
  
//  GETS
  func getScore()-> Int{
    return score
  }
  func getTextQuestion() -> String {
    return questions[numQuestion].text
  }
  func getProgress()-> Float {
    let progress = Float(numQuestion + 1) /  Float(questions.count)
    return progress
  }
  func getColor()-> UIColor {
    return questions[numQuestion].color
  }
  func getImage() -> UIImage{
    return questions[numQuestion].image
  }
  
  
  
}
