//
//  GameViewController.swift
//  hangman
//
//  Created by Sebastian Ortiz Velez on 10/01/2019.
//  Copyright © 2019 Sebastian Ortiz Velez. All rights reserved.
//

import UIKit

/*
 ImageView playerImage;
 TextView tv_userWord;
 EditText et_userLetter
 */
var userWord : String
var userLetter : String // --> la letra que introduce el usuario en cada turno
var cont:Int = 0

var gameUserWord: [Character] = [Character]()
var encriptedUserWord: [Character] = [Character]()

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
