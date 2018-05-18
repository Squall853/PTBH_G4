//
//  ViewController.swift
//  PTBH_G4
//
//  Created by Boi on 5/16/18.
//  Copyright © 2018 Boi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tfC: UITextField!
    @IBOutlet weak var tfB: UITextField!
    @IBOutlet weak var tfA: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // kiểm tra hợp lệ
    func checkNumber(a: String) -> Bool {
        var Count: Int = 0
        var t = a
            while !t.isEmpty{
                let index = t.index(t.startIndex, offsetBy: 1)
                if t.substring(to: index) == "."
                {
                    Count += 1
                    if Count > 1
                    {
                        return false
                    }
                }
                else if (t.substring(to: index) < "0" || t.substring(to: index) > "9") && t.substring(to: index) != "-" && t.substring(to: index) != "/"
                {
                    return false
                }
                t = t.chomp
            }
        return true
        }
    func kq(tf: String) -> Double {
        let exp: NSExpression = NSExpression(format: "1.0*"+tf)
        return exp.expressionValue(with: nil, context: nil) as! Double
    }

    @IBAction func btnCal(_ sender: UIButton) {
        if checkNumber(a: tfA.text!) == true && checkNumber(a: tfB.text!) == true && checkNumber(a: tfC.text!) == true && tfA.text != "" && tfB.text != "" && tfC.text != "" && tfA.text != "." && tfB.text != "." && tfC.text != "." && tfA.text != "-" && tfB.text != "-" && tfC.text != "-"
        {
       label.text = calculate(a: kq(tf: tfA.text!), b: kq(tf: tfB.text!), c: kq(tf: tfC.text!))
        }
        else
        {
            label.text = "Không hợp lệ!!!"
        }
    }
    
    func calculate(a: Double, b: Double, c: Double) -> String {
        var result1: Double!
        var result2: Double!
        
        if a == 0
        {
            result1 = round(((-c)/b) * 1000) / 1000
            return "x = \(result1!)"
        }
        else
        {
            let delta = b * b - 4 * a * c
            if delta < 0
            {
                result1 = nil
                result2 = nil
                return "Vô nghiệm"
            }
            else if delta == 0
            {
                result1 = -b / (2 * 	a)
                result2 = result1
                return "Nghiệm kép x1 = x2 = \(result1!)"
            }
            else
            {
                result1 = round( ((-b + sqrt(delta)) / (2 * a))*1000)/1000
                result2 = round( ((-b - sqrt(delta)) / (2 * a))*1000)/1000
                return "x1 = \(result1!)\nx2 = \(result2!)"
            }
        }
    }
    // vuốt trái +/-
    @IBAction func ANegative(_ sender: UISwipeGestureRecognizer) {
        tfA.text = makeNegative(num: tfA.text!)
        tfA.becomeFirstResponder()
    }
    @IBAction func BNegative(_ sender: UISwipeGestureRecognizer) {
        tfB.text = makeNegative(num: tfB.text!)
        tfB.becomeFirstResponder()
    }
    @IBAction func CNegative(_ sender: UISwipeGestureRecognizer) {
        tfC.text = makeNegative(num: tfC.text!)
        tfC.becomeFirstResponder()
    }
    // vuốt xuống thêm dấu chấm
    @IBAction func ADock(_ sender: UISwipeGestureRecognizer) {
        tfA.text = tfA.text! + "."
        tfA.becomeFirstResponder()
    }
    
    @IBAction func BDock(_ sender: UISwipeGestureRecognizer) {
        tfB.text = tfB.text! + "."
        tfB.becomeFirstResponder()
    }
    @IBAction func CDock(_ sender: UISwipeGestureRecognizer) {
        tfC.text = tfC.text! + "."
        tfC.becomeFirstResponder()
    }
    // +/-
    func makeNegative(num: String) -> String {
        if !num.isEmpty{
            let index = num.index(num.startIndex, offsetBy: 1)
            print("num[0]=" + num.substring(to: index))
            if num.substring(to: index) != "-"
            {
                if num.substring(to: index) != "."
                {
                    return "-" + num
                }
                else
                {
                    return "-0."
                }
            }
            else{
                var temp = num
                return temp.chomp
            }
        }
        return ""
    }
}
// xoá kí tự đầu của chuổi
extension String{
    var chomp : String {
        mutating get {
            self.remove(at: self.startIndex)
            return self
        }
    }
}

