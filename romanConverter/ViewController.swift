//
//  ViewController.swift
//  romanConverter
//
//  Created by Emircan saglam on 9.01.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var romanNumeric: UITextField!
    @IBOutlet weak var sonuc: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cevirButton(_ sender: Any) {
        var romenDict  = ["M" : 1000 , "D" : 500 , "C" : 100, "L" : 50, "X" : 10 , "V" : 5, "I" : 1]
        var num = 0
        var specialCases = ["IV" : 4, "IX": 9, "XL": 40, "XC": 90,"CD": 400, "CM": 900]
        var alfabe = ["M", "D", "C", "L", "X", "V","I"]
       
        var input = romanNumeric.text
        let inputArr = Array(input!)
        var str2 = ""
        var number = 0
        var isCorrect = true
        
        
        for i in inputArr {
            
            for j in alfabe{
                
                
                if String(i).elementsEqual(String(j))  {
                   isCorrect = true
                    errorLabel.text = ""
                    break
                }else{
                    isCorrect = false
                    errorLabel.text = "Yanlış Kullanım!!"
                    sonuc.text = ""
                }
            }
        }
        
        if isCorrect{
            for var i in 0..<inputArr.count {
                
                if inputArr.count == 1 {
                    num = romenDict[String(inputArr[i])]!
                    sonuc.text = String(num)
                    isCorrect = false
                }
                
                if i != inputArr.count-1 {
                    if romenDict[String(inputArr[i])]! < romenDict[String(inputArr[i+1])]! {
                        str2 = String(inputArr[i]) + String(inputArr[i+1])
                        for (k, v) in specialCases{
                            if k == str2 {
                               number += 1
                            }
                        }
                        if number > 0{
                            num += romenDict[String(inputArr[i+1])]! - romenDict[String(inputArr[i])]!
                            num -= romenDict[String(inputArr[i+1])]!
                            number = 0
                        }else {
                            isCorrect = false
                            errorLabel.text = "Yanlış Kullanım!!!"
                            sonuc.text = ""
                        }
                        
                    }else{
                        num += romenDict[String(inputArr[i])]!
                    }
                }
            }
        }
        
        
                
            
        
        if isCorrect{
            var str = String(inputArr.last!)
            num += romenDict[str]!
            sonuc.text = String(num)
            errorLabel.text = ""
        }
        
            
        
        
            
       /* for i in romenDigit {
            print(i)
            for j in input! {
                if i.elementsEqual(String(j)) {
                    print("eşit")
                    break
                    
                }else  {
                    print("Hata")
                    break*/
           
    
        
        
        
        
    }
    
    @IBAction func favoriEkle(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let yeniFavori = NSEntityDescription.insertNewObject(forEntityName: "Favoriler", into: context)
        
        yeniFavori.setValue(romanNumeric.text!, forKey: "romanNumb")
        yeniFavori.setValue(sonuc.text!, forKey: "normalNumb")
        yeniFavori.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("succes")
        }catch{
            print("error")
        }
        
    }
    
    
    
    
    @IBAction func favoriGoster(_ sender: Any) {
    }
    
}

