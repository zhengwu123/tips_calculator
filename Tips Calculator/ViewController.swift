//
//  ViewController.swift
//  Tips Calculator
//
//  Created by New on 12/24/15.
//  Copyright © 2015 New. All rights reserved.
//@author zheng wu , 0027374097 , wu673@purdue.edu

import UIKit
var tableString = [String]()
class ViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet var currencybutton: UIButton!
    @IBOutlet var setting: UIBarButtonItem!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var Label2: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var tipsLabel: UILabel!
    @IBOutlet var seg: UISegmentedControl!
    @IBOutlet var billText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults().objectForKey("tableString") != nil {
        tableString = NSUserDefaults.standardUserDefaults().objectForKey("tableString") as! [String]
        // Do any additional setup after loading the view, typically from a nib.
        }
        tipsLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
     var index = 0
    @IBAction func currencyButtonPressed(sender: AnyObject) {
        
        if(index<4){
        index += 1
        }
        if(index == 1){
        currencybutton.setTitle("£", forState: UIControlState.Normal)
        }
        if(index == 2){
            currencybutton.setTitle("$", forState: UIControlState.Normal)
        }
        if(index == 3){
            currencybutton.setTitle("€", forState: UIControlState.Normal)
        }
        if(index == 4){
            currencybutton.setTitle("￥", forState: UIControlState.Normal)
           
        }
        
    }
     var textString = ""
    @IBAction func SettingPressed(sender: AnyObject) {
        
        
        var tField: UITextField!
     
        
        func configurationTextField(textField: UITextField!)
        {
           // println("generating the TextField")
           // tField.keyboardType  = UIKeyboardType.NumberPad
            textField.placeholder = "eg: 0.19"
            textField.keyboardType = UIKeyboardType.DecimalPad
            tField = textField
        }
        
        
        func handleCancel(alertView: UIAlertAction!)
        {
           self.seg.hidden = false
        }
        
        let alert = UIAlertController(title: "Enter Prefered Tips percentage", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            //println("Done !!")
            //println("Item : \(tField.text)")
            var total1 = 0.0
            if tField.text != nil {
                self.seg.hidden = true
                let billAmount = NSString(string: self.billText.text!).doubleValue
                let percent = NSString(string: tField.text!).doubleValue
                if(billAmount != 0){
                let tips = billAmount * percent
                total1 = billAmount+tips
                  let currencysign = self.currencybutton.titleLabel?.text
               self.tipsLabel.text = String(format: currencysign! + " : %.2f", tips)
                self.totalLabel.text = String(format: currencysign! + " : %.2f", total1)
                self.Label2.text = String(format: "Shared by two people : %.2f each", total1/2)
                self.label3.text = String(format: "Shared by three people : %.2f each", total1/3)
                self.label4.text = String(format: "Shared by four people : %.2f each", total1/4)
                self.label5.text = String(format: "Shared by five people : %.2f each", total1/5)
                self.label6.text = String(format: "Shared by six people : %.2f each", total1/6)
                }
            }
        }))
        self.presentViewController(alert, animated: true, completion: {
           // println("completion block")
        })    }
    
  
      var total = 0.0
    @IBAction func OnEditChange(sender: AnyObject) {
        var percentages = [0.15,0.18,0.20,0.25]
        let percent = percentages[seg.selectedSegmentIndex]
        let billAmount = NSString(string: billText.text!).doubleValue
        if(billAmount != 0.0){
        let tips = billAmount * percent
        total = billAmount+tips
        1234567.descriptionWithLocale(NSLocale.currentLocale())
        let currencysign = currencybutton.titleLabel?.text
            
        self.tipsLabel.text = String(format: currencysign! + " : %.2f", tips)
        self.totalLabel.text = String(format: currencysign! + " : %.2f", total)
        Label2.text = String(format: "Shared by two people : %.2f each", total/2)
        label3.text = String(format: "Shared by three people : %.2f each", total/3)
        label4.text = String(format: "Shared by four people : %.2f each", total/4)
        label5.text = String(format: "Shared by five people : %.2f each", total/5)
        label6.text = String(format: "Shared by six people : %.2f each", total/6)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var shortDate: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.stringFromDate(NSDate())
    }

    @IBAction func pressed(sender: AnyObject) {
        let stringtotal:String = String(format:"%.2f", total)
       let currencysign = currencybutton.titleLabel?.text
         tableString.append( shortDate + " spend " + currencysign! + stringtotal)
        NSUserDefaults.standardUserDefaults().setObject(tableString, forKey: "tableString")
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
   

}

