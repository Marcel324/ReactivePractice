//
//  ViewController.swift
//  ReactivePractice
//
//  Created by Marcel Chaucer on 12/3/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var reactiveButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var reactingLabel: UILabel!
    
    var contentChangeObserver: Signal<String, NoError>.Observer!
    var contentChangeSignal: Signal<String, NoError>!
    var labelText = MutableProperty<String>("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let (contentChangeSignal, contentChangeObserver) = Signal<String, NoError>.pipe()
        self.contentChangeSignal = contentChangeSignal
        self.contentChangeObserver = contentChangeObserver
        
        self.contentChangeSignal.observe(on: UIScheduler()).observeValues{ [weak self] value in
            self?.navigationItem.title = value
            self!.reactingLabel.text = self!.textField.text
            print("Button Pressed In Other View Controller")
        }
        buttonPressed()
        labelText.producer.start()
        textChange()
    }
    
    func randomColor() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func random() -> UIColor {
        return UIColor(red:   randomColor(),
                       green: randomColor(),
                       blue:  randomColor(),
                       alpha: 1.0)
    }
    

    func textChange() {
        textField.reactive.continuousTextValues.observeValues { values in
            self.reactingLabel.reactive.text <~ self.labelText.signal
            self.reactingLabel.text = self.textField.text
            self.labelText.value = self.reactingLabel.text!
            print("this is the producers value: \(self.labelText.value)")
        }       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNextPage" {
            let destination = segue.destination as! SecondViewController
//            destination.contentChangeObserver = self.contentChangeObserver
            
            print(labelText.value)
        }
    }
    
    
    func buttonPressed() {
        reactiveButton.reactive.controlEvents(.touchUpInside).observe(on: UIScheduler()).observeValues { [weak self] _ in
            print("touchUpInside")
            self!.view.backgroundColor = self!.random()
        }
      
        reactiveButton.reactive.controlEvents(.touchDragOutside).observe(on: UIScheduler()).observeValues { [weak self]  _ in
            print("touchDragOutside")
            print("User Interactions: \(self?.reactingLabel.reactive.base.interactions)")
        }
    }

}

