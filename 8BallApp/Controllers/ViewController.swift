//
//  ViewController.swift
//  8BallApp
//
//  Created by Rita on 19.10.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let mainLabel = UILabel()
    private let textField = UITextField()
    private let ballAnswerLabel = UILabel()
    private let ballEmojiLabel = UILabel()
    private let replayButton = UIButton()
    
    private let repository: Repository
    
    private let defaultString = "Ask a question and shake the phone"
    
    init(repository: Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        setupSubviews()
        setupNavigationBar()
    }
    
    @objc func editButtonTapped() {
        print("tap")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "settings" else { return }
        guard let destinationVC = segue.destination as? SettingsViewController else { return }
        destinationVC.repository = repository
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let text = textField.text, !text.isEmpty else { return }
        textField.endEditing(true)
        repository.fetchData { (answer) in
            DispatchQueue.main.async {
                self.ballAnswerLabel.text = answer
                self.ballAnswerLabel.isHidden = false
                self.mainLabel.text = self.textField.text
                self.textField.isHidden = true
                self.replayButton.isHidden = false
            }
        }
    }
    
    @objc private func askAgainTapped(_ sender: UIButton) {
        textField.text = ""
        textField.isHidden = false
        mainLabel.text = defaultString
        replayButton.isHidden = true
        ballAnswerLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
    
    private func setupSubviews() {
        view.backgroundColor = .systemPurple
        
        view.addSubview(ballEmojiLabel)
        ballEmojiLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(305)
        }
        ballEmojiLabel.text = "🔮"
        ballEmojiLabel.textAlignment = .center
        ballEmojiLabel.font = ballEmojiLabel.font.withSize(280)
        
        view.addSubview(ballAnswerLabel)
        ballAnswerLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(180)
        }
        ballAnswerLabel.textAlignment = .center
        ballAnswerLabel.textColor = .white
        
        view.addSubview(replayButton)
        replayButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.width.equalTo(160)
        }
        replayButton.setTitle("Change question", for: .normal)
        replayButton.setTitleColor(.white, for: .normal)
        replayButton.layer.cornerRadius = 15
        replayButton.layer.borderWidth = 2.0
        replayButton.layer.borderColor = (UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)).cgColor
        replayButton.clipsToBounds = true
        replayButton.isHidden = true
        replayButton.addTarget(self, action: #selector(askAgainTapped), for: .touchUpInside)
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(75)
            make.height.equalTo(44)
        }
        mainLabel.text = "Ask a question and shake the phone"
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(mainLabel.snp.bottom).inset(-30)
            make.height.equalTo(30)
        }
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 6
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(editButtonTapped))
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
