//
//  SettingsViewController.swift
//  Tanelus_Prework
//
//  Created by Aramis on 7/23/21.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var topTipBox: UITextField!
    @IBOutlet weak var midTipBox: UITextField!
    @IBOutlet weak var bottomTipBox: UITextField!
   
    static let currencyList: [String] = ["$","€","£","₫","₺","৳","¥","₪","₾","฿","₽","₹","₡","₱","₦","₲","₩","₴"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let lastRow = defaults.integer(forKey: "currencyPickerRow")
        self.currencyPicker.selectRow(lastRow, inComponent: 0, animated: true)
        
        let tipPresets = defaults.array(forKey: "presetTipValues") as? [Int] ?? [15, 18, 20]
        topTipBox.text = String(tipPresets[0])
        midTipBox.text = String(tipPresets[1])
        bottomTipBox.text = String(tipPresets[2])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SettingsViewController.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SettingsViewController.currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: "currencyPickerRow")
        defaults.synchronize()
    }
    
    func getTipBoxes() -> [Int]{
        var tipValues: [Int] = []
        let textValues: [String] = [
            topTipBox.text ?? "",
            midTipBox.text ?? "",
            bottomTipBox.text ?? ""
        ]
        
        for textVal in textValues {
            if let intVal = Int(textVal) {
                tipValues.append(intVal)
            } else {
                tipValues.append(0)
            }
        }
        tipValues.sort()
        return tipValues
    }
    
    
    @IBAction func updateTipCache(_ sender: Any) {
        var tipValues = getTipBoxes()
        let defaults = [15, 18, 20]
        for i in 0..<3 {
            if tipValues[i] == 0 {
                tipValues[i] = defaults[i]
            }
        }
        tipValues.sort()
        
        let userdefaults = UserDefaults.standard
        userdefaults.setValue(tipValues, forKey: "presetTipValues")
        userdefaults.synchronize()
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
