//
//  BaseAuthViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 23.05.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var cantSignInLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    var authService: AuthService!
    var email: String?
    
    enum spacing {
        static let titleLabel: CGFloat = 20
        static let descriptionLabel: CGFloat = 46
        static let emailTextField: CGFloat = 5
        static let emailErrorLabel: CGFloat = 15
        static let passwordTextField: CGFloat = 5
        static let passwordErrorLabel: CGFloat = 15
        static let signInButton: CGFloat = 30
        static let cantSignInLabel: CGFloat = 0
    }
}

extension SignInViewController {
    
    private func configure() {
        configureStackView()
        
        emailTextField.text = email
    }
    
    private func configureStackView() {
        stackView.setCustomSpacing(spacing.titleLabel, after: titleLabel)
        stackView.setCustomSpacing(spacing.descriptionLabel, after: descriptionLabel)
        stackView.setCustomSpacing(spacing.emailTextField, after: emailTextField)
        stackView.setCustomSpacing(spacing.emailErrorLabel, after: emailErrorLabel)
        stackView.setCustomSpacing(spacing.passwordTextField, after: passwordTextField)
        stackView.setCustomSpacing(spacing.passwordErrorLabel, after: passwordErrorLabel)
        stackView.setCustomSpacing(spacing.signInButton, after: signInButton)
        stackView.setCustomSpacing(spacing.cantSignInLabel, after: cantSignInLabel)
    }
    
    private func signUp() {
        let controller = assembly.ui.auth()
        navigationController?.replaceTopViewController(with: controller, animated: true)
    }
}

extension SignInViewController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailErrorLabel.text?.removeAll()
        } else if textField == passwordTextField {
            passwordErrorLabel.text?.removeAll()
        }
    }
}
