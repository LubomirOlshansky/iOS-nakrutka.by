//
//  ViewController.swift
//  nakrutka.by
//
//  Created by Lubomir Olshansky on 06/02/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var apiInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func enterButton(_ sender: Any) {
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkApiKey()
        if !checkResult {
            showLoginError()
        }
        return checkResult
    }
    
    func checkApiKey() -> Bool {
        let apiKey = String(apiInput.text!)
        let apiKeyCount = apiKey.count
        if apiKeyCount == 32 {
            let instance = ApiKeySingletone.shared
            instance.apiKey = apiKey
            return true
        } else {
            return false
        }
    }
    func showLoginError() {
        let alert = UIAlertController(title: "Error", message: "Invalid apiKey. Please try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        apiInput.text = ""
    }
}

