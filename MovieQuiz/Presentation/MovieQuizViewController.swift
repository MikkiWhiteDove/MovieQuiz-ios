import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    // MARK: - Private properties
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var alertPresenter: AlertPresenterProtocol?
    private var presenter: MovieQuizPresenter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingIndicator()
        alertPresenter = AlertPresenter(self)
        addFontAndRadiusInCode()
        presenter = MovieQuizPresenter(viewController: self)
        
    }
    
    // MARK: - Actions
    @IBAction private func yesButtonClicked(_ sender: Any) {
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        presenter.noButtonClicked()
    }
    
    
    // MARK: - Private functions
    private func addFontAndRadiusInCode() {
        noButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        yesButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        titleLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        textLabel.font = UIFont(name: "YSDisplay-Bold", size: 23)
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        imageView.layer.cornerRadius = 20
    }
    
    // MARK: - Functions
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func showAlertModel(with model: AlertModel, id: String) {
        let alertModel = AlertModel(
            title: model.title,
            message: model.message,
            buttonText: model.buttonText,
            buttonAction: model.buttonAction
        )
        alertPresenter?.show(alertModel: alertModel, id: id)
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        yesButton.isEnabled = false
        noButton.isEnabled = false
    }
    
    func returnEverythingAsItWas() {
        yesButton.isEnabled = true
        noButton.isEnabled = true
        imageView.layer.borderWidth = 0
    }
}
