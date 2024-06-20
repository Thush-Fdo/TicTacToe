//
//  ViewController.swift
//  TicTacToe
//
//  Created by Shermin Fernando on 19/01/2024.
//

import UIKit

class ViewController: UIViewController {

    enum Turn{
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var noughtsScores = 0;
    var crossesScores = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
        
        self.resetBoard()
    }

    @IBAction func boardTabAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS){
            crossesScores += 1
            resultAlert(title: "Crosses Win")
        }
        
        if checkForVictory(NOUGHT){
            noughtsScores += 1
            resultAlert(title: "Noughts Win")
        }
        if fullBoard() {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s: String) -> Bool {
        
        //horizontal voctory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s){
            recolorWinningTiles(a1)
            recolorWinningTiles(a2)
            recolorWinningTiles(a3)
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s){
            recolorWinningTiles(b1)
            recolorWinningTiles(b2)
            recolorWinningTiles(b3)
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s){
            recolorWinningTiles(c1)
            recolorWinningTiles(c2)
            recolorWinningTiles(c3)
            return true
        }
        
        //vertical   voctory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s){
            recolorWinningTiles(a1)
            recolorWinningTiles(b1)
            recolorWinningTiles(c1)
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s){
            recolorWinningTiles(a2)
            recolorWinningTiles(b2)
            recolorWinningTiles(c2)
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s){
            recolorWinningTiles(a3)
            recolorWinningTiles(b3)
            recolorWinningTiles(c3)
            return true
        }
        
        //diagnal voctory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s){
            recolorWinningTiles(a1)
            recolorWinningTiles(b2)
            recolorWinningTiles(c3)
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s){
            recolorWinningTiles(a3)
            recolorWinningTiles(b2)
            recolorWinningTiles(c1)
            return true
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let message = "\nNoughts " + String(noughtsScores) + "\n\nCrosses " + String(crossesScores)
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        ac.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
        
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        
        self.present(ac, animated: true)
    }
    
    func recolorWinningTiles(_ sender: UIButton){
        sender.backgroundColor = UIColor.yellow
    }
    
    func resetBoard() {
        for button in board {
            button.isEnabled = true
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.white
        }
        
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == "" {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == ""{
            if currentTurn == Turn.Nought {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if currentTurn == Turn.Cross {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.titleLabel?.font = .systemFont(ofSize: 60.0, weight: .heavy)
            sender.isEnabled = false
        }
    }
    
}

