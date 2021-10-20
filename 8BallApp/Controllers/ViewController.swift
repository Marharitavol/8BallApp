//
//  ViewController.swift
//  8BallApp
//
//  Created by Rita on 19.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var ballAnswerLabel: UILabel!
    @IBOutlet weak var ballEmojiLabel: UILabel!
    @IBOutlet weak var replayButton: UIButton!
    
    private let defaultString = "Ask a question and shake the phone"
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        setupReplayButton()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let text = textField.text, !text.isEmpty else { return }
        textField.endEditing(true)
        networkManager.fetchData { (answer) in
            DispatchQueue.main.async {
                self.ballAnswerLabel.text = answer
                self.ballAnswerLabel.isHidden = false
                self.mainLabel.text = self.textField.text
                self.textField.isHidden = true
                self.replayButton.isHidden = false
            }
        }
    }
    
    @IBAction func askAgainTapped(_ sender: UIButton) {
        textField.isHidden = false
        mainLabel.text = defaultString
        replayButton.isHidden = true
        ballAnswerLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
    
    private func setupReplayButton() {
        replayButton.isHidden = true
        replayButton.layer.cornerRadius = 15
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

