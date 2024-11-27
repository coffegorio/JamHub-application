//
//  SceneDelegate.swift
//  JHApp
//
//  Created by Егорио on 24.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(with: scene)
        checkAuthentication()
    }

    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }

    public func checkAuthentication() {
        if let currentUser = Auth.auth().currentUser {
            print("Пользователь авторизован: \(currentUser.email ?? "неизвестно")")
            goToController(with: HomeScreenVC())  // Если пользователь авторизован, показываем HomeScreen
        } else {
            print("Пользователь не авторизован.")
            goToController(with: WelcomeScreenVC())  // Если нет, показываем WelcomeScreen
        }
    }

    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25, animations: {
                self?.window?.layer.opacity = 0
            }) { [weak self] _ in
                let navigationController = UINavigationController(rootViewController: viewController)
                self?.window?.rootViewController = navigationController
                UIView.animate(withDuration: 0.25) {
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
}
