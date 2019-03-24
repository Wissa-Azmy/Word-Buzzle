//
//  ViewController.swift
//  Word Buzzle
//
//  Created by Wissa Azmy on 3/20/19.
//  Copyright © 2019 Wissa Azmy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var scoreLabel: UILabel!
    var answerLabel: UILabel!
    var cluesLabel: UILabel!
    var answerText: UITextField!
    var submitBtn: UIButton!
    var clearBtn: UIButton!
    var buttonsView: UIView!
    var letterBtns = [UIButton]()
    var activatedBtns = [UIButton]()
    
    var solutions = [String]()
    var score = 0
    var level = 1

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answerLabel.textAlignment = .right
        answerLabel.text = "ANSWER"
        answerLabel.numberOfLines = 0
        view.addSubview(answerLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabel.textAlignment = .left
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
        
        answerText = UITextField()
        answerText.translatesAutoresizingMaskIntoConstraints = false
        answerText.placeholder = "Tap Letters to Guess"
        answerText.textAlignment = .center
        answerText.font = UIFont.systemFont(ofSize: 44)
        answerText.isUserInteractionEnabled = false
        view.addSubview(answerText)
        
        submitBtn = UIButton(type: .system)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        submitBtn.setTitle("SUBMIT", for: .normal)
        submitBtn.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
        view.addSubview(submitBtn)
        
        clearBtn = UIButton(type: .system)
        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        clearBtn.setTitle("CLEAR", for: .normal)
        clearBtn.addTarget(self, action: #selector(clearBtnTapped), for: .touchUpInside)
        view.addSubview(clearBtn)
        
        buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(
                equalTo: view.layoutMarginsGuide.topAnchor, constant: 0
            ),
            scoreLabel.trailingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0
            ),
            
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 0),
            answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: -100),
            
            cluesLabel.topAnchor.constraint(equalTo: answerLabel.topAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.heightAnchor.constraint(equalTo: answerLabel.heightAnchor),
            cluesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -100),
            
            answerText.topAnchor.constraint(equalTo:answerLabel.bottomAnchor, constant: 20),
            answerText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            submitBtn.topAnchor.constraint(equalTo: answerText.bottomAnchor),
            submitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submitBtn.heightAnchor.constraint(equalToConstant: 44),
            
            clearBtn.topAnchor.constraint(equalTo: answerText.bottomAnchor),
            clearBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clearBtn.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.topAnchor.constraint(equalTo: submitBtn.bottomAnchor, constant: 20),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        
        let btnHeight = 80
        let btnWidth = 150
        
        for row in 0..<4 {
            for column in 0..<5 {
                let btnFrame = CGRect(x: column * btnWidth, y: row * btnHeight, width: btnWidth, height: btnHeight)
                let letterBtn = UIButton(type: .system)
                letterBtn.frame = btnFrame
                letterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterBtn.setTitle("WWW", for: .normal)
                letterBtn.titleLabel?.textColor = .blue
                buttonsView.addSubview(letterBtn)
                letterBtns.append(letterBtn)
                letterBtn.addTarget(self, action: #selector(letterBtnTapped), for: .touchUpInside)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadLevel()
    }


    @objc func letterBtnTapped(_ sender: UIButton) {
        
    }
    
    
    @objc func submitBtnTapped(_ sender: UIButton) {
        
    }
    
    
    @objc func clearBtnTapped(_ sender: UIButton) {
        
    }
    
    
    private func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ":")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
                
                answerLabel.text = solutionString
                cluesLabel.text = clueString
                
                for (index, btn) in letterBtns.enumerated() {
                    btn.setTitle(letterBits[index], for: .normal)
                }
            }
        }

    }
}

