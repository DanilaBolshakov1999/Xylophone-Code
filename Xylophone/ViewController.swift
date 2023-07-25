//
//  ViewController.swift
//  Xylophone
//
//  Created by IOS - Developer  on 13.07.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private let nameButton = ["A", "C", "B", "F", "G", "E", "D"]
    private let buttonStackView = UIStackView()
    
    private var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstrains()
        createButtons()
    }
    
    private func createButtons() {
        for (index, nameButton) in nameButton.enumerated() {
            let multiplierWidth = 0.97 - (0.03 * Double(index))
            createButton(name: nameButton, width: multiplierWidth)
        }
    }
    
    private func createButton(name: String, width: Double) {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 45)
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(button)
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: width).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
        button.backgroundColor = getColor(for: name)
    }
    
    private func getColor(for name: String) -> UIColor {
        switch name {
        case "A": return .systemRed
        case "C": return .systemOrange
        case "B": return .systemYellow
        case "F": return .systemGreen
        case "G": return .systemIndigo
        case "E": return .systemBlue
        case "D": return .systemPurple
        default: return .white
        }
    }
    
    func toggleButtonAlpha(_ button: UIButton) {
        button.alpha = button.alpha == 1 ? 0.5 : 1
    }
    
    func playSound(_ buttonText: String) {
        guard let url = Bundle.main.url(forResource: buttonText, withExtension: "wav") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @objc private func buttonsTapped(_ sender: UIButton) {
        toggleButtonAlpha(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.toggleButtonAlpha(sender)
        }
        guard let buttonText = sender.currentTitle else { return }
        playSound(buttonText)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
    }
}
    
    extension ViewController {
        private func setView() {
            view.backgroundColor = .white
            view.addSubview(buttonStackView)
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            buttonStackView.alignment = .center
            buttonStackView.axis = .vertical
            buttonStackView.spacing = 10
            buttonStackView.distribution = .fillEqually
            
        }
        
        private func setConstrains() {
            NSLayoutConstraint.activate([
                buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        }
    }



