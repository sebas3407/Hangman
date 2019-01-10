//
//  GameViewController.swift
//  hangman
//
//  Created by Sebastian Ortiz Velez on 10/01/2019.
//  Copyright © 2019 Sebastian Ortiz Velez. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    /*
     ImageView playerImage;
     EditText et_userLetter
     */
    @IBOutlet weak var tv_userWord: UILabel!
    
    var userWord : String = ""
    var userLetter : String = "" // --> la letra que introduce el usuario en cada turno
    var cont:Int = 0
    
    var gameUserWord: [Character] = [Character]()
    var encriptedUserWord: [Character] = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func EncriptWord()
    {
        for i in stride(from: 0, to: userWord.count, by: 1)
        {
            encriptedUserWord.append("_")
            
            //      tv_userWord.setText(tv_userWord.getText().toString() + encriptedUserWord[i] + " ")
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
                    //  tv_userWord.setText(tv_userWord.getText().toString() + encriptedUserWord[e] + " ")
                }
                letterFound = true;
            }
        }
        
        return letterFound;
    }
    
    func Play() {
        
    //    userLetter = et_userLetter.getText().toString().toUpperCase();
    
        //evitamos que el usuario ponga espacios en blanco
        if(userLetter.isEmpty){
            return;
        }
    
     //   et_userLetter.setText("");
    
        var letterfound : Bool
        letterfound = IsLetterFound(letter : userLetter[userLetter.startIndex])
    
        if (!letterfound) {
    
            if (cont == 0) {
         //   imagen.setImageResource(R.drawable.dos);
            cont = 1;
            } else if (cont == 1) {
      //      imagen.setImageResource(R.drawable.tres);
            cont = 2;
            } else if (cont == 2) {
        //    imagen.setImageResource(R.drawable.cuatro);
            cont = 3;
            } else if (cont == 3) {
         //   imagen.setImageResource(R.drawable.cinco);
            cont = 4;
            } else if (cont == 4) {
          //  imagen.setImageResource(R.drawable.seis);
            cont = 5;
            } else if (cont == 5) {
         //   imagen.setImageResource(R.drawable.siete);
            cont = 6;
            } else if (cont == 6) {
        //    imagen.setImageResource(R.drawable.ocho);
            cont = 7;
            } else if (cont == 7) {
          //  imagen.setImageResource(R.drawable.nueve);
            cont = 8;
            } else if (cont == 8) {
         //   imagen.setImageResource(R.drawable.diez);
            cont = 9;
            } else if (cont == 9) {
         //   imagen.setImageResource(R.drawable.once);
            cont = 10;
            } else {
         //   imagen.setImageResource(R.drawable.doce);
            cont = 0;
    
        //    Intent i = new Intent(game.this, gameOver.class);
        //    startActivity(i);
    
    
            }
        //cont++;
        }
        else{
    
    
        //comprobamos si el usuario ha adivinado la palabra, usando la funcion replaceAll para quitar los espacios
            /*
        if(tv_userWord.getText().toString().replaceAll("\\s+","").equals(userWord))
            {
        
                Intent myIntent = new Intent(game.this, win.class);
                startActivity(myIntent);
            }
            */
        }
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


