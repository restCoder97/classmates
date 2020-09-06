//
//  customWidget.swift
//  ECampus
//
//  Created by Bill Chen on 8/28/20.
//  Copyright © 2020 Youxing Chen. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore;
import FacebookLogin
import FBSDKLoginKit

class WGT{
    
   
    var top:CGFloat = 0;
    var bot:CGFloat = 0;
    var safePT : CGFloat = 0;
    var safeBT : CGFloat = 0;
    let H = UIScreen.main.bounds.size.height
    let W = UIScreen.main.bounds.size.width
    init() {
    }
    func rountdPicBt(pic:UIImage,pos:CGRect,fatherView:UIView)->UIButton{
        let button = UIButton(type: .custom)
        button.frame = pos
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        
        
        button.setImage(pic, for: .normal)
        fatherView.addSubview(button)
        return button;
    }
    
    func btGenerate(textColor:UIColor,backColor:UIColor,title:String, fatherView:UIView,position:CGRect)->UIButton{
          let aBt=UIButton.init(frame: position)
          aBt.setTitle(title, for: .normal)
          aBt.setTitleColor(textColor, for: .normal)
          aBt.layer.cornerRadius = 20
          aBt.layer.shadowRadius=8;
            aBt.backgroundColor=backColor
          fatherView.addSubview(aBt);
        aBt.titleLabel!.font = .systemFont(ofSize: 14)
        aBt.layer.shadowColor = UIColor.init(white: 0, alpha: 0.161).cgColor;
        aBt.layer.shadowOffset = CGSize(width: 0, height: 0);
        aBt.layer.shadowRadius = 8;
        aBt.layer.shadowOpacity = 1
          return aBt;
      }
    
    func labelGenerator(position:CGRect,text:String,fatherView:UIView,txtColor:UIColor,bKColor:UIColor)->UILabel{
        let lb=UILabel.init(frame:position)
        lb.backgroundColor=bKColor;
        lb.textColor=txtColor;
        lb.text=text
        fatherView.addSubview(lb)
        return lb;
    }
    
    func tfGenerator(position:CGRect,text:String,fatherView:UIView,dNum:Bool,Num:Bool,PassWord:Bool)->UITextField
    {
        let textField = UITextField(frame:position)
        textField.backgroundColor=UIColor.white
        textField.textColor=UIColor.black;
        textField.attributedPlaceholder = NSAttributedString(string: text,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        //textField.borderStyle = UITextField.BorderStyle.roundedRect
        //textField.borderStyle=UITextField.BorderStyle.roundedRect
        
        textField.layer.masksToBounds = true;
        textField.layer.borderWidth = 0;
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.adjustsFontSizeToFitWidth = true;
        textField.font = UIFont(name: "AppleSystemUIFont", size: 10)
        textField.leftViewMode = .always
        let leftView = UIView.init(frame:CGRect.init(x:0, y: 0, width:15/414*W, height: 20))
        textField.leftView = leftView
        textField.font = .systemFont(ofSize: 14)
        textField.layer.shadowColor = UIColor.init(white: 0, alpha: 1).cgColor;
        textField.layer.shadowOffset = CGSize(width: 0, height: 0);
        textField.layer.shadowRadius = 8;
        textField.layer.shadowOpacity = 1
        textField.layer.cornerRadius = 20
        
        
        if(dNum){
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        else if(Num){
            textField.keyboardType = UIKeyboardType.numberPad
        }
        textField.isSecureTextEntry=PassWord;
        textField.becomeFirstResponder()
        textField.resignFirstResponder()
        textField.placeholder=text
        fatherView.addSubview(textField)
        
        //textField.delegate = self
        
        return textField
    }
    
}



class pickView:UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var items :[String] = [];
    var btOk = UIButton();
    var textColor = UIColor();
    let H = UIScreen.main.bounds.size.height
    let W = UIScreen.main.bounds.size.width
    var pk = UIPickerView();
    var ptAim  : UnsafeMutablePointer<String>?
    var titleLabel=UILabel();
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    convenience init(name: String,position: CGRect, txtColor:UIColor,data:[String],result:UnsafeMutablePointer<String>){
        self.init();
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        items = data;
        textColor = txtColor;
        ptAim = result;
        
        
        pk.frame = CGRect(x:0,y:H*2/3,width: W,height: H/4)
        self.pk.delegate = self
        self.pk.dataSource = self
        self.pk.backgroundColor = UIColor.black;
        
        /////////////////////////////////////////bt OK//////////////////////////////////////////////
        self.btOk = UIButton.init(frame: CGRect(x:0,y:pk.frame.maxY,width: W,height: H/12));
        self.btOk.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1);
        self.btOk.setTitleColor(UIColor.systemBlue, for: .normal);
        self.btOk.setTitle("OK", for: .normal);
        self.view.addSubview(btOk);self.view.addSubview(pk);
        btOk.addTarget(self, action: #selector(btOkDown), for: UIControl.Event.touchUpInside);
        ///////////////////////////////////////////title Label///////////////////////////////////////
        self.titleLabel = WGT().labelGenerator(position: CGRect(x:0,y:H*2/3-H/20,width: W,height: H/20), text: name, fatherView: self.view,txtColor: UIColor.white,bKColor: UIColor.black);
        titleLabel.textAlignment = .center;
        
    
    }
    @objc func btOkDown(){
        ptAim!.pointee = items [pk.selectedRow(inComponent: 0)];
        self.dismiss(animated: true, completion: nil);
    }
    
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = items[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return items[row];
    }
   
    init() {
         super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches {
            let t:UITouch = touch as! UITouch
            if(!self.pk.frame.contains(t.location(in: self.view))){
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
}


