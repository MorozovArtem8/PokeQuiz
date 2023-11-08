//
//  ViewController.swift
//  PokeQuiz
//
//  Created by Artem Morozov on 06.11.2023.
//

import UIKit
enum Mode{
    case pokeCard
    case pokeQuiz
}
enum State{
    case question
    case answer
}

class ViewController: UIViewController {
    
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    let fixedPokeList = createArrayStruct(array: pokeArray)
    var pokeList: [Poke] = []
    var currentElementIndex = 0
    var state = State.question{
        didSet{
            switch state{
            case .question:
                if modeSelector.selectedSegmentIndex == 0 {
                    nextButton.isHidden = false
                }
            case .answer:
                buttonView.isHidden = true
                nextButton.isHidden = false
            }
        }
    }
    var mode = Mode.pokeCard{
        didSet{
            if modeSelector.selectedSegmentIndex == 0 {
                nextButton.isHidden = false
            }
            updateUI()
        }
    }
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        
    }
    
    //Answer button Tapp
    @IBAction func oneButtonTap(_ sender: UIButton) {
        if buttonOne.currentTitle == pokeList[currentElementIndex].name{
            answerLabel.text = "Заебись"
            correctAnswerCount += 1
        }else{
            answerLabel.text = "хуйня"
        }
        state = .answer
    }
    @IBAction func twoButtonTap(_ sender: UIButton) {
        if buttonTwo.currentTitle == pokeList[currentElementIndex].name{
            answerLabel.text = "Заебись"
            correctAnswerCount += 1
        }else{
            answerLabel.text = "хуйня"
        }
        state = .answer
    }
    @IBAction func threeButtonTap(_ sender: UIButton) {
        if buttonThree.currentTitle == pokeList[currentElementIndex].name{
            answerLabel.text = "Заебись"
            correctAnswerCount += 1
        }else{
            answerLabel.text = "хуйня"
        }
        state = .answer
    }
    @IBAction func fourButtonTap(_ sender: UIButton) {
        if buttonFour.currentTitle == pokeList[currentElementIndex].name{
            answerLabel.text = "Заебись"
            correctAnswerCount += 1
        }else{
            answerLabel.text = "хуйня"
        }
        state = .answer
    }
    
    
    @IBAction func switchModes(_ sender: UISegmentedControl) {
        if modeSelector.selectedSegmentIndex == 0{
            mode = .pokeCard
        }else{
            mode = .pokeQuiz
        }
        updateUI()
    }
    @IBAction func showAnswer(_ sender: UIButton) {
        state = .answer
        updateUI()
    }
    
    @IBAction func next(_ sender: UIButton) {
        currentElementIndex += 1
        switch mode {
        case .pokeCard:
            if currentElementIndex >= fixedPokeList.count{
                currentElementIndex = 0
            }
            state = .question
            updateUI()
        case .pokeQuiz:
            if currentElementIndex >= fixedPokeList.count{
                
                dissplayScoreAlert()
                modeSelector.selectedSegmentIndex = 0
                currentElementIndex = 0
                correctAnswerCount = 0
                mode = .pokeCard
                updatePokeCardUI()
                
                
            }
            updatePokeQuizUI()
            state = .question
            updateImageNextQuiz(mode)
        }
        
    }
    func updateUI(){
        updateImageControl(mode)
        
        switch mode{
        case .pokeCard:
            updatePokeCardUI()
        case .pokeQuiz:
            updatePokeQuizUI()
        }
    }
    
    func updatePokeCardUI(){
        buttonView.isHidden = true
        showAnswerButton.isHidden = false
        buttonOne.setTitle("", for: .normal)
        buttonTwo.setTitle("", for: .normal)
        buttonThree.setTitle("", for: .normal)
        buttonFour.setTitle("", for: .normal)
        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            answerLabel.text = fixedPokeList[currentElementIndex].name
        }
        
    }
    
    func updatePokeQuizUI(){
        nextButton.isHidden = true
        buttonView.isHidden = false
        showAnswerButton.isHidden = true
        answerLabel.text = ""
        
        let buttons: [UIButton] = [buttonOne, buttonTwo, buttonThree, buttonFour]
        var randomBttons: [UIButton] = buttons.shuffled()
        randomBttons[0].setTitle(pokeList[currentElementIndex].name, for: .normal)
        var newArrayPoke = pokeList
        newArrayPoke.remove(at: currentElementIndex)
        for i in 1..<randomBttons.count{
            var randomIndex = Int.random(in: 0...newArrayPoke.count - 1)
            randomBttons[i].setTitle(newArrayPoke[randomIndex].name, for: .normal)
            newArrayPoke.remove(at: randomIndex)
            
            
        }
        
    }
    
    func updateImageControl(_ mode: Mode){
        switch mode {
        case .pokeCard:
            let pokeName = fixedPokeList[currentElementIndex].name
            let image = UIImage(named: pokeName)
            imageView.image = image
        case .pokeQuiz:
            pokeList = fixedPokeList.shuffled()
            let pokeName = pokeList[currentElementIndex].name
            let image = UIImage(named: pokeName)
            imageView.image = image
        }
    }
    
    func updateImageNextQuiz(_ mode: Mode){
        
        let pokeName = pokeList[currentElementIndex].name
        let image = UIImage(named: pokeName)
        imageView.image = image
    }
    
    //Allert
    
    func dissplayScoreAlert() {
        let alert = UIAlertController(title: "Результат", message: "Твои очки \(correctAnswerCount) из \(pokeList.count)", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: scoreAlertDismissed(_:))
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .pokeCard
    }
    
    

}

