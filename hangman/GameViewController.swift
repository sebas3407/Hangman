//
//  GameViewController.swift
//  hangman
//
//  Created by Sebastian Ortiz Velez on 10/01/2019.
//  Copyright © 2019 Sebastian Ortiz Velez. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var tv_userWord: UILabel!
    
    var userWord : String = "SES"
    var userLetter : String = "" // --> the letter introduced by user on each turn 
    var cont : Int = 0
    
    var gameUserWord: [Character] = [Character]()
    var encriptedUserWord: [Character] = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EncriptWord()
    }
    
    func getRandomWord(){
        
    }
    
    func EncriptWord()
    {
        gameUserWord = Array(userWord)
        for i in stride(from: 0, to: userWord.count, by: 1)
        {
            encriptedUserWord.append("*")
            tv_userWord.text = (tv_userWord.text)! + "\(encriptedUserWord[i])"
        }
    }
    
    func IsLetterFound(letter: Character) -> Bool {
        
        var letterFound : Bool = false
        
        for i in stride(from: 0, to: userWord.count, by: 1)
        {
            if (gameUserWord[i] == letter) {
                
                tv_userWord.text = ""
                encriptedUserWord[i] = letter
                
                for e in stride(from: 0, to: userWord.count, by: 1)
                {
                    tv_userWord.text = (tv_userWord.text)! + "\(encriptedUserWord[e])"
                }
                
                letterFound = true;
            }
        }
        
        return letterFound;
    }
    
    
    @IBAction func setUserLetter(_ sender: Any) {

        let btn : UIButton = sender as! UIButton
        userLetter = (btn.accessibilityLabel!)
        Play()
    }
    
    func Play() {
        
        var letterfound : Bool
        letterfound = IsLetterFound(letter : userLetter[userLetter.startIndex])
        
        if (!letterfound) {
            
            if (cont == 0) {
                playerImage.image = UIImage(named: "dos.jpg")
                cont = 1;
            } else if (cont == 1) {
                playerImage.image = UIImage(named: "tres.jpg")
                cont = 2;
            } else if (cont == 2) {
                playerImage.image = UIImage(named: "cuatro.jpg")
                cont = 3;
            } else if (cont == 3) {
                playerImage.image = UIImage(named: "cinco.jpg")
                cont = 4;
            } else if (cont == 4) {
                playerImage.image = UIImage(named: "seis.jpg")
                cont = 5;
            } else if (cont == 5) {
                playerImage.image = UIImage(named: "siete.jpg")
                cont = 6;
            } else if (cont == 6) {
                playerImage.image = UIImage(named: "ocho.jpg")
                cont = 7;
            } else if (cont == 7) {
                playerImage.image = UIImage(named: "nueve.jpg")
                cont = 8;
            } else if (cont == 8) {
                playerImage.image = UIImage(named: "diez.jpg")
                cont = 9;
            } else if (cont == 9) {
                playerImage.image = UIImage(named: "once.jpg")
                cont = 10;
            } else {
                playerImage.image = UIImage(named: "doce.jpg")
                //GAMEOVER
                resetGame(status: 0)
            }
        }
        else{
            /* Check if the user guess the word, to check this, we use the function
             trimingCharacters to delete whitespaces */
            
            if (tv_userWord.text!.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual(userWord)){
                //WIN THE GAME
                resetGame(status: 1)
            }
        }
    }
    
    func resetGame(status : Int){
        
        tv_userWord.text = ""

        playerImage.image = UIImage(named: "uno.jpg")
        
        var message : String = ""
        
        if(status == 0){
            message = "Sorry, you don't guess the secret word, do you want to try again or quit the game?"
        }
        else{
            message = "Congratulations, you are the winner, do you want to try again or quit the game?"
        }
        
        let myalert = UIAlertController(title: "END GAME", message: message, preferredStyle: UIAlertController.Style.alert)
        
        myalert.addAction(UIAlertAction(title: "Restart", style: .default) { (action:UIAlertAction!) in
            self.getRandomWord()
            self.EncriptWord()
        })
        myalert.addAction(UIAlertAction(title: "Quit the game", style: .cancel) { (action:UIAlertAction!) in
            exit(0)
        })
        
        self.present(myalert, animated: true)
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
