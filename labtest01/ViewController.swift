//
//  ViewController.swift
//  labtest01
//
//  Created by Lovice Sunuwar on 18/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Potatoes
        case Cross
        
    }
    
    
    
    @IBOutlet weak var oscore: UILabel!
    @IBOutlet weak var xscore: UILabel!
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
    
   
    let savestate = UserDefaults.standard.bool(forKey: "savegame")
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var POTATOES = "O"
    var CROSS = "X"
    var BLANK = ""
    var board = [UIButton]()
    
    var potatoScore = 0
    var crossScore = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        becomeFirstResponder()
        
        xscore.text = "\(crossScore)"
        oscore.text = "\(potatoScore)"
        
      let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        swipeRight.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        // Do any additional setup after loading the view.
        
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
            if motion == .motionShake{
                let alert = UIAlertController(title: "Undo the move ?", message:"Your last move will be removed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Accept", style: .cancel, handler: nil))
                present(alert, animated: true)
                
            }
            undoMove()
    }
    
    
    
    @objc func swipeFunc(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            newGame()
        }
        
        else if gesture.direction == .right {
            newGame()
        }

    }
    
    func initBoard()
    {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS)
        {
            crossScore += 1
            xscore.text = "\(crossScore)"
            resultAlert(title: "Crosses Wins!!!")
        }
        if checkForVictory(POTATOES)
        {
            potatoScore += 1
            oscore.text = "\(potatoScore)"
            resultAlert(title: "Potatoes Wins!!!")
        }
        if(fullBoard())
        {
            resultAlert(title: "DRAW")
        }
        
        UserDefaults.standard.set(sender.isEnabled, forKey: "savegame")
        
        
    }
    
    func checkForVictory(_ s : String) -> Bool {
        // Horizontal victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        //Vertical victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
            return true
        }
        //Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
            return true
        }
        
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        
        _ = "\nPotatoes " + String(potatoScore) + "\nCrosses " + String(crossScore)
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in self.resetBoard()}))
        self.present(ac, animated: true)
    }
    /*
    func swipeLeftorRight(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .right:
            newGame()
        case .left:
            newGame()
        default:
            print("")
        }
    }
    */
    func resetBoard()
    {
        for button in board{
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.Potatoes)
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if(firstTurn == Turn.Cross)
        {
            firstTurn = Turn.Potatoes
            turnLabel.text = POTATOES
        }
    }
    
    func undoMove()
    {
        for button in board{
           button.setTitle(nil, for: .normal)
            button.isEnabled = true
            
        }
        if(firstTurn == Turn.Potatoes)
        {
            
            firstTurn = Turn.Cross
            turnLabel.text = POTATOES
        }
        else if(firstTurn == Turn.Cross)
        {
            firstTurn = Turn.Potatoes
            turnLabel.text = CROSS
        }
    }
    func newGame(){
        xscore.text = ""
        oscore.text = ""
        potatoScore = 0
        crossScore = 0
        
        for button in board{
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.Potatoes)
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if(firstTurn == Turn.Cross)
        {
            firstTurn = Turn.Potatoes
            turnLabel.text = POTATOES
        }
        
    }
    func fullBoard() -> Bool {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if (currentTurn == Turn.Potatoes)
            {
                sender.setTitle(POTATOES, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
                UserDefaults.standard.set(sender.isEnabled, forKey: "savegame")
            }
            else if (currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Potatoes
                turnLabel.text = POTATOES
                UserDefaults.standard.set(sender.isEnabled, forKey: "savegame")
            }
            sender.isEnabled = false
            
        }
        
    }
 
    func undoToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if (currentTurn == Turn.Potatoes)
            {
                sender.setTitle(BLANK, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
                UserDefaults.standard.set(sender.isEnabled, forKey: "savegame")
            }
            else if (currentTurn == Turn.Cross)
            {
                sender.setTitle(BLANK, for: .normal)
                currentTurn = Turn.Potatoes
                turnLabel.text = POTATOES
                UserDefaults.standard.set(sender.isEnabled, forKey: "savegame")
            }
            sender.isEnabled = false
            
        }
        
    }
    
}


