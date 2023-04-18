//
//  ViewController.swift
//  FindNumber
//
//  Created by Students on 06.01.2023.
//

import UIKit

// stop at 10:39 lesson 6

class ViewController: UIViewController {

    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var statusGame: UILabel!
    
    @IBOutlet weak var nextDigit: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self] status, seconds in
        
        guard let self = self else {return}
        self.timerLabel.text = "\(seconds)"
    }
    
//    [
//    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12",
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }

    @IBAction func pressButton(_ sender: UIButton) {
        
        guard let indexButton = buttons.firstIndex(of: sender) else {return}
        game.check(index: indexButton)
        
        updateUI()
        
//        //sender.isHidden = true
//        sender.tintColor = .white
//        print(sender.tag)
    }
    
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
             
        }
        
        nextDigit.text = game.nextItem?.title
        
    }
    
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].isHidden = game.items[index].isFound
        }
        
        nextDigit.text = game.nextItem?.title
        
        if game.status == .win {
            statusGame.text = "You win"
            statusGame.textColor = .green
        }
    }
    
    
    
}

