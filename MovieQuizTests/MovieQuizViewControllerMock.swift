//
//  MovieQuizViewControllerMock.swift
//  MovieQuizTests
//
//  Created by Mishana on 24.08.2023.
//

import XCTest

@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
    func returnEverythingAsItWas() {
        
    }
    
    func show(quiz step: MovieQuiz.QuizStepViewModel) {
        
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func showAlertModel(with model: MovieQuiz.AlertModel, id: String) {
        
    }
}
