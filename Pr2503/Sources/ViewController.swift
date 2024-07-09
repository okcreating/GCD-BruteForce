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
        activityIndicator.isHidden = false


        activityIndicator.startAnimating()
        textField.text = getRandomString()


    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        //self.bruteForce(passwordToUnlock: "1!gr")

    }

    // MARK: Methods

    private var isThemeBlack: Bool = false {
        didSet {
            if isThemeBlack {
                self.view.backgroundColor = .black
                label.textColor = .white
                activityIndicator.color = .blue
            } else {
                self.view.backgroundColor = .white
            }
        }
    }

    private func getRandomString() -> String {
        let lenth = 4
        return String((0...lenth).compactMap { _ in
            (String().printable.randomElement())
        })

        //return generatedString
    }

    private func bruteForce(passwordToUnlock: String) {
        // let allowedCharacters: [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = bruteForce.generateBruteForce(password, fromArray: allowedCharacters)
            //             Your stuff here
            print(password)
            // Your stuff here
        }

        print(password)
    }
}



// генерацию пароля положить в диспатчайтем
// затем в notify ввксти пароль, скрыть индикатор и тп (в главной очереди тк UI) модер все действия вывести в метод
// workitem (генерация) на неглавной очереди асинхронно и потом notify на главную + код что выполнить
