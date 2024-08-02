//
//  ViewController.swift
//  Apple Login Demo
//
//  Created by Shahid Ghafoor on 01/08/2024.
//

import UIKit
import AuthenticationServices


class ViewController: UIViewController {
    
    private let signInButton = ASAuthorizationAppleIDButton()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(signInButton)
//        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        signInButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
//        signInButton.center = view.center
    }

    @IBAction func appleLoginButtonPressed(_ sender: UIButton) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let userIdentifier = credentials.user
            let fullName = credentials.fullName
            let email = credentials.email

            print("user ID: \(userIdentifier)  name: \(fullName)  email: \(email)")
            break
        case let passwordCredential as ASPasswordCredential:
                    // Handle password credentials
            break
        default:
            break
        }
    }
}


extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
