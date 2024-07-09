import UIKit

class ViewController: UIViewController {

    //var generatedCode = ""

    // MARK: Outlets

    @IBOutlet weak var changeThemeButton: UIButton!
    @IBOutlet weak var generatePasswordButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: Properties

    let allowedCharacters: [String] = String().printable.map { String($0) }

    private var isThemeBlack: Bool = false {
        didSet {
            if isThemeBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }
    
    // MARK: Actions

    @IBAction func changeTheme(_ sender: UIButton) {
        isThemeBlack.toggle()
    }
    
    @IBAction func generatePassword(_ sender: UIButton) {
        textField.isSecureTextEntry = true
        textField.text = getRandomString()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bruteForce(passwordToUnlock: "1!gr")

    }

    // MARK: Methods

    private func getRandomString() -> String {
        let lenth = 6
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
            password = generateBruteForce(password, fromArray: allowedCharacters)
//             Your stuff here
            print(password)
            // Your stuff here
        }
        
        print(password)
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
}

// MARK: Extension

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }


// заменяем символ по индексу в массиве
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
                               : Character("")
}



// генерацию пароля положить в диспатчайтем
// затем в notify ввксти пароль, скрыть индикатор и тп (в главной очереди тк UI) модер все действия вывести в метод
// workitem (генерация) на неглавной очереди асинхронно и потом notify на главную + код что выполнить
