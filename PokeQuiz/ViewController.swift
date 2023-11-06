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
    let fixedPokeList = createArrayStruct(array: pokeArray)
    var pokeList: [Poke] = []
    var currentElementIndex = 0
    var state = State.question
    var mode = Mode.pokeCard
    
    
   

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
        if currentElementIndex >= fixedPokeList.count{
            currentElementIndex = 0
        }
        state = .question
        updateUI()
    }
    func updateUI(){
        updateImage(mode)
        
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
        buttonView.isHidden = false
        showAnswerButton.isHidden = true
        answerLabel.text = ""
        
        let buttons: [UIButton] = [buttonOne, buttonTwo, buttonThree, buttonFour]
        var randomBttons: [UIButton] = buttons.shuffled()
        randomBttons[0].setTitle(pokeList[currentElementIndex].name, for: .normal)
        for butt in randomBttons {
            var nextNumber = currentElementIndex
            if butt == randomBttons[0]{
                continue
            }
            butt.setTitle(pokeList[nextNumber + 1].name, for: .normal)
            nextNumber += 1
        }
        
    }
    
    func updateImage(_ mode: Mode){
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
    
    

}

