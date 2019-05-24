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
    
    var userWord : String = " "
    var userLetter : String = "" // --> the letter introduced by user on each turn 
    var cont : Int = 0
    
    let apiKey = "49d4b069434f6fde9a71a02f4c607138f418f82f792e55264"
    
    var gameUserWord: [Character] = [Character]()
    var encriptedUserWord: [Character] = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_userWord.text = ""
        getRandomWord()
    }
    
    func getRandomWord(){

        //Implementing URLSession
        let urlString = "http://api.wordnik.com/v4/words.json/randomWord?api_key=49d4b069434f6fde9a71a02f4c607138f418f82f792e55264"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let dataFromUrl = data else { return }
            do {
                
                guard let randomWorld = try? JSONDecoder().decode(RandomWord.self, from: dataFromUrl)  else{
                    print("Error: Couldn't decode data")
                    return
                }
                
                self.userWord = randomWorld.word.uppercased()
                print("La palabra es \(randomWorld.word)")

                DispatchQueue.main.async {
                    self.EncriptWord()
                }
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
    }
    
    func EncriptWord()
    {
        encriptedUserWord = [Character]()
        gameUserWord = Array(userWord)
        
        for i in 0..<userWord.count {
            encriptedUserWord.append("*")
            tv_userWord.text = (tv_userWord.text)! + "\(encriptedUserWord[i])"
        }
    }
    
    func IsLetterFound(letter: Character) -> Bool {
        
        var letterFound : Bool = false
        
        for i in 0..<userWord.count {

            if (gameUserWord[i] == letter) {
                
                tv_userWord.text = ""
                encriptedUserWord[i] = letter
                
                for e in 0..<userWord.count{
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
        Play(btn)
    }
    
    func Play(_ sender : Any) {
        
        let btn : UIButton = sender as! UIButton
        
        var letterfound : Bool
        letterfound = IsLetterFound(letter : userLetter[userLetter.startIndex])
        
        if (!letterfound) {
            btn.backgroundColor = UIColor.red

            cont = cont + 1

            /*
                playerImage.image = UIImage(named: "doce.jpg")
                //GAMEOVER
                resetGame(status: 0)
            */
        }
        else{
            
            btn.backgroundColor = UIColor.green

            /* Check if the user guess the word, to check this, we use the function
             trimingCharacters to delete whitespaces */
            
            if (tv_userWord.text!.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual(userWord)){
                //WIN THE GAME
                resetGame(status: 1)
            }
        }
    }
    
    func resetGame(status : Int){
        self.tv_userWord.text = ""
        cont = 0
//        playerImage.image = UIImage(named: "uno.jpg")
        /*
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
 */
        for tagvalue in 1...26 {
            let btnTemp = self.view.viewWithTag(tagvalue) as! UIButton
            btnTemp.backgroundColor = UIColor.clear
        }
    }
}
