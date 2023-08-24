//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Mishana on 24.08.2023.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func showFinalResults()
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showNetworkError(message: String)
    func returnEverythingAsItWas()
}
