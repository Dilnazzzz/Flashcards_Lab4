//
//  CreationViewController.swift
//  Flashcards_optional
//
//  Created by Dilnaz on 3/12/21.
//

import UIKit

class CreationViewController: UIViewController {

    @IBOutlet weak var Question: UITextField!
    @IBOutlet weak var Answer: UITextField!
    
    var flashcardsController: ViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let frontLabel = Question.text
        
        let backLabel = Answer.text
        
        flashcardsController.updateFlashcard(Question: frontLabel!, Answer: backLabel!)
        
        dismiss(animated: true)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
