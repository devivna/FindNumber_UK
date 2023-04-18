//
//  Game.swift
//  FindNumber
//
//  Created by Students on 06.01.2023.
//

import Foundation

enum StatusGame {
    case win
    case start
    case lose
}

class Game {
    
    struct Item {
        var title: String
        var isFound: Bool = false
    }
    
    private var dataNumbers = Array(1...99)
    
    var items: [Item] = []

    private var countItems: Int

    var nextItem: Item?
    
    var status: StatusGame = .start{
        didSet{
            if status != .start {
                stopGame()
            }
        }
    }
    
    private var timeForGame: Int{
        didSet{
            if timeForGame == 0 {
                status = .lose
            }
            updateTimer(status, timeForGame)
        }
    }
    private var timer: Timer?
    
    private var updateTimer: ((StatusGame, Int) -> Void)
    
    init(countItems: Int, time: Int, updateTimer: @escaping (_ status: StatusGame, _ seconds: Int) -> Void) {
        self.countItems = countItems
        timeForGame = time
        self.updateTimer = updateTimer
        setupGame()
    }
    
    private func setupGame() {
        var digits = dataNumbers.shuffled()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            self?.timeForGame -= 1
        })
    }
     
    func  check(index: Int) {
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { item -> Bool in
                item.isFound == false
            })
        }
        
        if nextItem == nil {
            status = .win
        }
        
    }
    
    private func stopGame() {
        timer?.invalidate()
    }
    
    
}
