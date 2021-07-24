//
//  SettingsViewController.swift
//  Tanelus_Prework
//
//  Created by Aramis on 7/23/21.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var currencyPicker: UIPickerView!
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
//        let selectedCurrency = SettingsViewController.currencyList[row]
        defaults.set(row, forKey: "currencyPickerRow")
        defaults.synchronize()
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
