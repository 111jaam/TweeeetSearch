//
//  TSVCSearchInput.swift
//  TweeeetSearch
//
//  Created by Bharat Byan on 16/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import UIKit
import MapKit

class TSVCSearchInput: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    var strSearchString = ""
    var strLocation = ""
    var strTime = ""
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MyVariables.isTweetTextON = false
        self.txtSearch.delegate = self
        
        locManager.requestWhenInUseAuthorization()
        strLocation = getlocation()
        
        strTime = "&result_type=recent"
        print("git") 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func actBtnSearch(_ sender: Any) {
        
        if (txtSearch.text?.length)! < 1 {
            let alertView = UIAlertController(title: "Message", message: "Kindly enter something in Search-Box.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                self.txtSearch.becomeFirstResponder()
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        }else{
            self.performSegue(withIdentifier: "sgiTSVCTweetsList", sender: nil)
        }
    }

    @IBAction func actBtnRefreshLocation(_ sender: Any) {
        strLocation = getlocation()
    }
    
    @IBAction func actBtnOnlyPictures(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            MyVariables.isTweetTextON = true
        }else{
            sender.isSelected = false
            MyVariables.isTweetTextON = false
        }
    }
    
    
    @IBAction func actBtnOnlyRadius(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            strLocation = ""
        }else{
            sender.isSelected = false
            strLocation = getlocation()
        }
    }
    
    
    @IBAction func actBtnOnlyTime(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            strTime = ""
        }else{
            sender.isSelected = false
            strTime = "&result_type=recent"
        }
    }
    
    
    func getlocation() -> String{
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            
            let lat = String.init(format: "%.6f", currentLocation.coordinate.latitude)
            let long = String.init(format: "%.6f", currentLocation.coordinate.longitude)
            
            print(lat)
            print(long)
            
            return "&geocode=\(lat),\(long),10km"
        }
        return ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyBoard()
        return false
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        hideKeyBoard()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyBoard()
        super.touchesBegan(touches, with: event)
    }
    
    func hideKeyBoard(){
        txtSearch.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        hideKeyBoard()
        
        if segue.identifier == "sgiTSVCTweetsList" {
            let destinationVC = segue.destination as! TSVCTweetsList
            destinationVC.strSearchString = self.txtSearch.text!
            destinationVC.strLocation = strLocation
            destinationVC.strTime = strTime
        }
    }

}
