//
//  OnboardingViewController.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 20/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import UIKit
import SafariServices

class OnboardingViewController: UIViewController {

    @IBOutlet weak var apiKeyTitleLabel: UILabel!
    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
    }

    private func applyStyling() {
        apiKeyTitleLabel.text = "Please enter the Bitrise Personal Access Token here. It will be stored securely in the app."
        apiKeyTextField.delegate = self
        doneButton.layer.cornerRadius = 8
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let apiKey = apiKeyTextField.text else { return }
        if OnboardingService.validateAPIKey(apiKey) {
            KeychainService.savePassword(apiKey)
            performSegue(withIdentifier: "unwindToAppListWithRefresh", sender: self)
        } else {
            showValidationAlert()
        }
    }

    private func showValidationAlert() {
        let alert = UIAlertController(title: "Error", message: "The Personal Access Token appears invalid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in}))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func helpButtonTapped(_ sender: Any) {
        guard let url = URL(string: "https://discuss.bitrise.io/t/personal-access-tokens-beta/1383") else { return }
        let helpViewController = SFSafariViewController(url: url)
        present(helpViewController, animated: true, completion: nil)
    }
}

extension OnboardingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneButtonTapped(self)
        return true
    }
}
