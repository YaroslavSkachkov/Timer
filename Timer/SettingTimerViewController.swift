//
//  SettingTimerViewController.swift
//  Timer
//
//  Created by Yaroslav Skachkov on 31.03.2018.
//  Copyright © 2018 Yaroslav Skachkov. All rights reserved.
//

import UIKit

class SettingTimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var settingScrollView: UIScrollView!
    @IBOutlet weak var workoutTextField: UITextField!
    @IBOutlet weak var restTextField: UITextField!
    
    
    let timeStamps = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    
    //MARK: Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeStamps.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            workoutTextField.text = timeStamps[row]
            workoutTextField.resignFirstResponder()
            
        } else if pickerView.tag == 2 {
            restTextField.text = timeStamps[row]
            restTextField.resignFirstResponder()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeStamps[row]
    }
    
    
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        settingScrollView.contentInset.bottom += adjustmentHeight
        settingScrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var workoutPickerView = UIPickerView()
        workoutPickerView.delegate = self
        workoutPickerView.tag = 1
        workoutTextField.inputView = workoutPickerView
        
        var restPickerView = UIPickerView()
        restPickerView.delegate = self
        restPickerView.tag = 2
        restTextField.inputView = restPickerView
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SettingTimerViewController.keyboardWillShow(_:)),
            name: Notification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SettingTimerViewController.keyboardWillHide(_:)),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil
        )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSetTimer" {
            if let destination = segue.destination as? ViewController {
                destination.workoutTime = Int(workoutTextField.text!)!
                destination.restTime = Int(restTextField.text!)!
            }
        } else if segue.identifier == "cancelSetTimer"{
            if let destination = segue.destination as? ViewController {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
