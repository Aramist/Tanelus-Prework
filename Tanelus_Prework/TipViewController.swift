//
//  ViewController.swift
//  Tanelus_Prework
//
//  Created by Aramis on 7/22/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currencySymbol: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tip Controller"
        let defaults = UserDefaults.standard
        let now = Date()
        if let lastBillTime = defaults.object(forKey: "billLastUpdated") as? Date {
            let tenMinutesFurther = lastBillTime.addingTimeInterval(60 * 10)
            if tenMinutesFurther > now {
                let oldBill = defaults.double(forKey: "lastBill")
                let oldBillString = oldBill > 0.0 ? String(format: "%.2f", oldBill) : ""
                billAmountTextField.text = oldBillString
            }
        }
        self.updateLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = UserDefaults.standard
        let currentTime = Date()
        defaults.setValue(currentTime, forKey: "billLastUpdated")
        defaults.synchronize()
    }
    
    func updateLabels() {
        let defaults = UserDefaults.standard
        // Default to USD if the unit has not been set yet
        let currencyRow = defaults.integer(forKey: "currencyPickerRow")
        let currencyUnit = SettingsViewController.currencyList[currencyRow]
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.20]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        defaults.setValue(bill, forKey: "lastBill")
        defaults.synchronize()
        
        currencySymbol.text = currencyUnit
        tipAmountLabel.text = String(format: "%@%.2f", currencyUnit, tip)
        totalLabel.text = String(format: "%@%.2f", currencyUnit, total)
    }
    
    // Modified to allow the total field to be updated when the bill is changed, without having to modify the tipControl selector
    @IBAction func calculateTip(_ sender: Any) {
        self.updateLabels()
    }
}

