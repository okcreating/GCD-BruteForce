import UIKit

class ViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var changeThemeButton: UIButton!
    @IBOutlet weak var generatePasswordButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: Properties

    var bruteForce = BruteForce()

    let allowedCharacters: [String] = String().printable.map { String($0) }

    // MARK: Actions

    @IBAction func changeTheme(_ sender: UIButton) {
        isThemeBlack.toggle()
    }

    @IBAction func generatePassword(_ sender: UIButton) {
        textField.isSecureTextEntry = true
        let password = getRandomString()
        label.text = password
        textField.text = password
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        DispatchQueue.global().async {
            self.bruteForce(passwordToUnlock: password)
            DispatchQueue.main.sync {
                self.activityIndicator.isHidden = true
                self.textField.isSecureTextEntry = false
            }
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }

    // MARK: Methods

    private var isThemeBlack: Bool = false {
        didSet {
            if isThemeBlack {
                self.view.backgroundColor = .black
                label.textColor = .white
            } else {
                self.view.backgroundColor = .white
                label.textColor = .black
            }
        }
    }

    private func getRandomString() -> String {
        let lenth = 3
        return String((1...lenth).compactMap { _ in
            (String().printable.randomElement())
        })
    }

    private func bruteForce(passwordToUnlock: String) {
        var password: String = ""
        while password != passwordToUnlock {
            password = bruteForce.generateBruteForce(password, fromArray: allowedCharacters)
            DispatchQueue.main.async {
                self.label.text = password
            }
        }
    }
}
