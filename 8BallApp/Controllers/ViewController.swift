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
    private var repository: RepositoryProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        setupReplayButton()
        setupRepository()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "settings" else { return }
        guard let destinationVC = segue.destination as? SettingsViewController else { return }
        destinationVC.repository = repository
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let text = textField.text, !text.isEmpty else { return }
        textField.endEditing(true)
        repository?.fetchData { (answer) in
            DispatchQueue.main.async {
                self.ballAnswerLabel.text = answer
                self.ballAnswerLabel.isHidden = false
                self.mainLabel.text = self.textField.text
                self.textField.isHidden = true
                self.replayButton.isHidden = false
            }
        }
    }
    
    @IBAction private func askAgainTapped(_ sender: UIButton) {
        textField.text = ""
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
    
    private func setupRepository() {
        repository = Repository(networkDataProvider: NetworkClient(), dBProvider: UserDefaultsManager())
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

