//
//  ViewController.swift
//  Tanelus_Prework
//
//  Created by Aramis on 7/22/21.
//

import UIKit

class TipViewController: UIViewController {

    
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currencySymbol: UILabel!
    
    @IBOutlet var keyboardButtonsOutlet: [UIButton]!
    
    // Things that need coloring:
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var keyboardBackground: UIView!
    
    
    // From left-to-right, top-to-bottom
    let keyboardButtons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "<"]
    var isExpanded: [Bool] = Array(repeating: false, count: 12)
    
    // red, off-white, light blue, darker blue, navy blue
    let colorPalette = [
        UIColor(red: 0.9019607843137255, green: 0.2235294117647059, blue: 0.27450980392156865, alpha: 1.0),
        UIColor(red: 0.9450980392156862, green: 0.9803921568627451, blue: 0.9333333333333333, alpha: 1.0),
        UIColor(red: 0.6588235294117647, green: 0.8549019607843137, blue: 0.8627450980392157, alpha: 1.0),
        UIColor(red: 0.27058823529411763, green: 0.4823529411764706, blue: 0.615686274509804, alpha: 1.0),
        UIColor(red: 0.11372549019607843, green: 0.20784313725490197, blue: 0.3411764705882353, alpha: 1.0)
    ]
    /* The colors as strings, just in case
        "e63946",
        "f1faee",
        "a8dadc",
        "457b9d",
        "1d3557"
     */
    
    // The label view in focus, for text entry purposes:
    var focusedView: UIView? = nil
    
    
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
                billAmountLabel.text = oldBillString
            }
        }
        self.updateLabels()
        
        self.isExpanded = Array(repeating: false, count: keyboardButtons.count)
        
        
        billAmountLabel.numberOfLines = 0
        billAmountLabel.sizeToFit()
        keyboardBackground.backgroundColor = colorPalette[0]
        for button in keyboardButtonsOutlet {
            button.setTitleColor(colorPalette[1], for: .normal)
        }
        backgroundView.backgroundColor = colorPalette[2]
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
    
    func updateTipController(withTips: [Int]) {
        for i in 0..<withTips.count {
            tipControl.setTitle("\(withTips[i])%", forSegmentAt: i)
        }
    }
    
    func updateLabels() {
        let defaults = UserDefaults.standard
        // Default to USD if the unit has not been set yet
        let currencyRow = defaults.integer(forKey: "currencyPickerRow")
        let currencyUnit = SettingsViewController.currencyList[currencyRow]
        let bill = Double(billAmountLabel.text!) ?? 0
        let tipPresets = defaults.array(forKey: "presetTipValues") as? [Int] ?? [15, 18, 20]
        updateTipController(withTips: tipPresets)
        let tip = bill * Double(tipPresets[tipControl.selectedSegmentIndex]) / 100.0
        let total = bill + tip
        
        defaults.setValue(bill, forKey: "lastBill")
        defaults.synchronize()
        
        currencySymbol.text = currencyUnit
        tipAmountLabel.text = String(format: "%@%.2f", currencyUnit, tip)
        totalLabel.text = String(format: "%@%.2f", currencyUnit, total)
        totalLabel.sizeToFit()
    }
    
    // Modified to allow the total field to be updated when the bill is changed, without having to modify the tipControl selector
    @IBAction func calculateTip(_ sender: Any) {
        self.updateLabels()
    }
    
    @IBAction func customKeypadPress(_ sender: Any) {
        if let keypadNum = sender as? UIButton {
            let char = keypadNum.title(for: .normal)!
            let oldText = billAmountLabel.text!
            if char == "." && oldText.contains("."){
                return
            } else if char != "<"{
                if !oldText.contains(".") {
                    billAmountLabel.text = oldText + char
                } else {
                    let endIndex = oldText.endIndex
                    let periodCheck = oldText.index(endIndex, offsetBy: -3)
                    if oldText.firstIndex(of: ".")! != periodCheck {
                        billAmountLabel.text = oldText + char
                    }
                }
            } else {
                if oldText.count > 0 {
                    let strIndex = oldText.index(oldText.endIndex, offsetBy: -1)
                    billAmountLabel.text = String(oldText.prefix(upTo: strIndex))
                }
            }
            billAmountLabel.sizeToFit()
            
            self.updateLabels()
        }
    }
    
    
    

}

