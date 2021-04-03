//
//  ViewController.swift
//  Flashcards_optional
//
//  Created by Dilnaz on 2/20/21.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var card: UIView!
    
    var flashcards = [Flashcard] ()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readSavedFlashcards()
        if flashcards.count == 0 { updateFlashcard(Question: "What is the capital of Brazil", Answer: "Brasilia") } else {updateLabels()
            updateNextPrevButtons()
            
        }
        
    }

   
    @IBAction func tap(_ sender: Any) {
        flipFlashcard()
        
    }
    
    func flipFlashcard() {
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {if self.frontLabel.isHidden {self.frontLabel.isHidden=false}
                          else {self.frontLabel.isHidden=true}})
        
    }
    
    func animateCardOut() {
        
        
        UIView.animate(withDuration: 0.3, animations: {self.card.transform=CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: {finished in self.updateLabels()
            self.animateCardIn()
            
        })
    }
    
    func animateCardIn() {
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3) {self.card.transform = CGAffineTransform.identity}
    }
    
    
    func updateFlashcard(Question: String, Answer: String) {
        let flashcard = Flashcard(question: Question, answer: Answer)
        
        flashcards.append(flashcard)
        print("Added a new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex) ")
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as!CreationViewController
        
        creationController.flashcardsController = self
    }
    
    
    func updateNextPrevButtons () {
        
        if currentIndex == 0 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        if currentIndex == flashcards.count - 1 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateNextPrevButtons()
        animateCardOut()
        
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateNextPrevButtons()
        animateCardOut()
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards [currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map{(card) -> [String:String] in
            return ["question": card.question, "answer": card.answer]}
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards () {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
}

