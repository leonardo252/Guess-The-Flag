//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Leonardo Gomes on 18/04/20.
//  Copyright © 2020 Leonardo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        */
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us" ]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // .layer don't know the UIColor, so we use .cgColor to convert a UIColor for that .layer can get the color
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showScore))
        
        
//        askQuestion(action: nil)
        askQuestion()
    }
//    func askQuestion(action: UIAlertAction!) {
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " - Score: \(score)"
        totalQuestions += 1
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            message = "Your score is \(score)"
            score += 1
        } else {
            title = "Wrong"
            message = "This flgas is from \(countries[sender.tag].uppercased()).\nYour score is \(score)"
            score -= 1
        }
        
        if totalQuestions == 10 {
            let finalManssage = "Afeter 10 questions, your score is \(score)"
            
            let final = UIAlertController(title: "Finished!", message: finalManssage, preferredStyle: .actionSheet)
            final.addAction(UIAlertAction(title: "OK", style: .cancel, handler: askQuestion))
            present(final, animated: true)
            
            totalQuestions = 0
            score = 0
            
        } else {
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    @objc func showScore() {
        let scoreToShow = "My total score is \(score)"
        let vc = UIActivityViewController(activityItems: [scoreToShow], applicationActivities: [])
//        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    
    }
    
}

