//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Mishana on 27.06.2023.
//

import Foundation
import UIKit

final class AlertPresenter {
    private weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension AlertPresenter: AlertPresenterProtocol {
    func show(alertModel: AlertModel,id identifier: String) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.buttonAction()
        }
        alert.view.accessibilityIdentifier = identifier
//        action.accessibilityIdentifier = identifier
        alert.addAction(action)
        viewController?.present(alert, animated: true)
    }
}
