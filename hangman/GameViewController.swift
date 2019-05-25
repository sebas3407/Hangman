//
//  GameViewController.swift
//  hangman
//
//  Created by Sebastian Ortiz Velez on 10/01/2019.
//  Copyright © 2019 Sebastian Ortiz Velez. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var manImage: UIImageView!
    
    @IBOutlet weak var girlImage: UIImageView!
    
    @IBOutlet weak var result_image: UIImageView!
    
    
    @IBOutlet weak var tv_userWord: UILabel!
    
    @IBOutlet weak var btn_reset: UIButton!
    
    var userWord : String = " "
    var userLetter : String = "" // --> the letter introduced by user on each turn 
    var cont : Int = 0
    
    let apiKey = "49d4b069434f6fde9a71a02f4c607138f418f82f792e55264"
    
    var gameUserWord: [Character] = [Character]()
    var encriptedUserWord: [Character] = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRound()
    }
    
    func startRound() {
        girlImage.image = UIImage(named: "smile.png")
        manImage.image = UIImage(named: "think.png")
        tv_userWord.text = ""
        btn_reset.isHidden = true
        result_image.isHidden = true
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

            if (cont == 12){
                girlImage.image = UIImage(named: "dead_girl.png")
                manImage.image = UIImage(named: "dead.png")
                result_image.image = UIImage(named: "failure.png")
                result_image.isHidden = false
                btn_reset.isHidden = false
            }
        }
        else{
            
            btn.backgroundColor = UIColor.green

            /* Check if the user guess the word, to check this, we use the function
             trimingCharacters to delete whitespaces */
            
            if (tv_userWord.text!.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual(userWord)){
                //WIN THE GAME
                btn_reset.isHidden = false
                girlImage.image = UIImage(named: "happy.png")
                manImage.image = UIImage(named: "glasses.png")
                result_image.isHidden = false
                result_image.image = UIImage(named: "tick.png")
            }
        }
    }
    
    @IBAction func resetGame(_ sender: Any) {
        self.btn_reset.isHidden = true
        self.tv_userWord.text = ""
        cont = 0
        
        for tagvalue in 1...26 {
            let btnTemp = self.view.viewWithTag(tagvalue) as! UIButton
            btnTemp.backgroundColor = UIColor.clear
        }
        startRound()
    }
}
