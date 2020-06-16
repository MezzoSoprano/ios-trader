//
//  BaseAuthViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 23.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var haveAccountLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailErrorLabel.text?.removeAll()
        passwordErrorLabel.text?.removeAll()
    }
    
    var authService: AuthService!
    
    enum spacing {
        static let titleLabel: CGFloat = 20
        static let descriptionLabel: CGFloat = 30
        static let emailTextField: CGFloat = 5
        static let emailErrorLabel: CGFloat = 15
        static let passwordTextField: CGFloat = 5
        static let passwordErrorLabel: CGFloat = 15
        static let signUpButton: CGFloat = 10
    }
}

extension SignUpViewController {
    
    private func configure() {
        configureStackView()
    }
        
    private func configureStackView() {
        stackView.setCustomSpacing(spacing.titleLabel, after: titleLabel)
        stackView.setCustomSpacing(spacing.descriptionLabel, after: descriptionLabel)
        stackView.setCustomSpacing(spacing.emailTextField, after: emailTextField)
        stackView.setCustomSpacing(spacing.emailErrorLabel, after: emailErrorLabel)
        stackView.setCustomSpacing(spacing.passwordTextField, after: passwordTextField)
        stackView.setCustomSpacing(spacing.passwordErrorLabel, after: passwordErrorLabel)
        stackView.setCustomSpacing(spacing.signUpButton, after: signUpButton)
    }
    
    private func signIn() {
        let controller = assembly.ui.auth()
        navigationController?.replaceTopViewController(with: controller, animated: true)
    }
}

extension SignUpViewController: UITextViewDelegate {
    
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailErrorLabel.text?.removeAll()
        } else if textField == passwordTextField {
            passwordErrorLabel.text?.removeAll()
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return false
    }
}
