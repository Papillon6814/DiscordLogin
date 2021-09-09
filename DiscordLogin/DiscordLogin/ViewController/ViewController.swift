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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let code = RealmHelper.shared.getAuthCode() else {
            return
        }
        
        model.retrieveTokens(code: code) { [weak self] result in
            print(result)
            self?.model.getUserInfo() { [weak self] username, discriminator in
                self?.usernameLabel.text = username
                self?.tagLabel.text = discriminator
            }
        }
    }
}

