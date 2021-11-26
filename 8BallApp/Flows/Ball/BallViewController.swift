//
//  ViewController.swift
//  8BallApp
//
//  Created by Rita on 19.10.2021.
//

import UIKit
import SnapKit

class BallViewController: UIViewController {

    private let viewModel: BallViewModel
    private let mainLabel = UILabel()
    private let textField = UITextField()
    private let ballAnswerLabel = UILabel()
    private let ballEmojiLabel = UILabel()
    private let replayButton = UIButton()

    init(viewModel: BallViewModel) {
        self.viewModel = viewModel
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
        setupReplayButton()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let text = textField.text, !text.isEmpty else { return }
        textField.endEditing(true)
        viewModel.shake { (answer) in
            DispatchQueue.main.async {
                self.ballAnswerLabel.text = answer
                self.ballAnswerLabel.isHidden = false
                self.mainLabel.text = self.textField.text
                self.textField.isHidden = true
                self.replayButton.isHidden = false
                self.viewModel.saveHistory(answer!)
            }
        }
    }

    @objc private func askAgainTapped(_ sender: UIButton) {
        textField.text = ""
        textField.isHidden = false
        mainLabel.text = L10n.ruleTitle
        replayButton.isHidden = true
        ballAnswerLabel.isHidden = true
    }
    
    @objc func editButtonTapped() {
        let settingsVC = SettingsViewController(viewModel: viewModel.getSettingsViewModel())
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
}

extension BallViewController {
    private func setupSubviews() {
        view.backgroundColor = Asset.purple.color
        view.addSubview(ballEmojiLabel)
        ballEmojiLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(305)
        }
        ballEmojiLabel.text = L10n.emoji
        ballEmojiLabel.textAlignment = .center
        ballEmojiLabel.font = ballEmojiLabel.font.withSize(280)

        view.addSubview(ballAnswerLabel)
        ballAnswerLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(180)
        }
        ballAnswerLabel.textAlignment = .center
        ballAnswerLabel.textColor = Asset.white.color

        view.addSubview(replayButton)
        replayButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.width.equalTo(160)
        }
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(75)
            make.height.equalTo(44)
        }
        mainLabel.text = L10n.ruleTitle
        mainLabel.textAlignment = .center
        mainLabel.textColor = .white

        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(mainLabel.snp.bottom).inset(-30)
            make.height.equalTo(30)
        }
        textField.backgroundColor = Asset.white.color
        textField.layer.cornerRadius = 6
    }
    
    private func setupReplayButton() {
        replayButton.setTitle(L10n.buttonText, for: .normal)
        replayButton.setTitleColor(Asset.white.color, for: .normal)
        replayButton.layer.cornerRadius = 15
        replayButton.layer.borderWidth = 2.0
        replayButton.layer.borderColor = Asset.white.color.cgColor
        replayButton.clipsToBounds = true
        replayButton.isHidden = true
        replayButton.addTarget(self, action: #selector(askAgainTapped), for: .touchUpInside)

    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = Asset.white.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Asset.icon.image,
            style: .done,
            target: self,
            action: #selector(editButtonTapped))
    }
}

extension BallViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
