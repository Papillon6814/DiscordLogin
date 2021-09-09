//
//  ViewController.swift
//  DiscordLogin
//
//  Created by Papillon on 2021/09/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    private var model: Model!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = Model()
    }
}

