//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Mishana on 23.08.2023.
//

import Foundation
import UIKit

final class MovieQuizPresenter {
    
    // MARK: - Private properties
    private weak var viewController: MovieQuizViewControllerProtocol?
    private var questionFactory: QuestionFactoryProtocol?
    private let statisticService: StatisticService!
    private var currentQuestion: QuizQuestion?
    private let questionsAmount: Int = 10
    private var currentQuestionIndex = 0
    private var correctAnswers: Int = 0
    
    init(viewController: MovieQuizViewControllerProtocol) {
        self.viewController = viewController
        
        statisticService = StatisticServiceImplementation()
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        viewController.showLoadingIndicator()
    }
    
    // MARK: - functions
    func isLastQuestion() -> Bool {
        questionsAmount - 1 == currentQuestionIndex
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        correctAnswers = 0
        questionFactory?.requestNextQuestion()
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    func makeResultMessage() -> String {
        
        guard let statisticService = statisticService, let bestGame = statisticService.bestGame else {
            assertionFailure("error best message")
            return ""
        }
        let totalPlaysCountLine = "Колличество сыгранных квизов: \(statisticService.gamesCount)"
        let currentGameResultLine = "Ваш результат: \(correctAnswers)\\\(questionsAmount)"
        let bestGameInfoLine = "Рекорд: \(bestGame.correct)\\\(bestGame.total)" + "(\(bestGame.date.dateTimeString))"
        let accuracy = String(format: "%.2f", statisticService.totalAccuracy)
        let avarageAccuracyLine = "Средняя точность: \(accuracy)%"
        let resultMessage = [
            currentGameResultLine, totalPlaysCountLine, bestGameInfoLine, avarageAccuracyLine
        ].joined(separator: "\n")
        
        return resultMessage
    }
    
    // MARK: - QuestionFactoryDelegate
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else { return }
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    // MARK: - Yes No Buttons
    
     func yesButtonClicked() {
        didAnswer(isYes: true)
    }
    
    func noButtonClicked() {
        didAnswer(isYes: false)
    }
    
    // MARK: - Private func
    private func didAnswer(isYes: Bool) {
        guard let currentQuestion = currentQuestion else { return }
        let givenAnswer = isYes
        proceedWithAnswer(isCorrect: currentQuestion.correctAnswer == givenAnswer)
    }
    
    private func proceedWithAnswer(isCorrect: Bool) {
        
        didAnswerCorrect(isCorrectAnswer: isCorrect)
        viewController?.highlightImageBorder(isCorrectAnswer: isCorrect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.viewController?.returnEverythingAsItWas()
            self.proceedToNextQuestionOrResult()
        }
    }
    
    private func proceedToNextQuestionOrResult() {
        if isLastQuestion() {
            statisticService.store(correct: correctAnswers, total: questionsAmount)
            let id = "Game results"
            let message = makeResultMessage()
            let alertModel = AlertModel(
                title: "Этот раунд окончен!",
                message: message,
                buttonText: "Сыграть ещё раз",
                buttonAction: { [weak self] in
                    guard let self = self else { return }
                    self.restartGame()
                }
            )
            viewController?.showAlertModel(with: alertModel, id: id)
        }else {
            switchToNextQuestion()
            questionFactory?.requestNextQuestion()
        }
    }
    
    private func didAnswerCorrect(isCorrectAnswer: Bool) {
        correctAnswers += isCorrectAnswer ? 1 : 0
    }
}

// MARK: - QuestionFactoryDelegate
extension MovieQuizPresenter: QuestionFactoryDelegate {
    func didLoadDataFromServer() {
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        let id = "Error Network"
        let message = error.localizedDescription
        let alertModel = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать еще раз",
            buttonAction: { [weak self] in
                guard let self = self else { return }
                self.restartGame()
            }
        )
        viewController?.showAlertModel(with: alertModel, id: id)
    }
}
