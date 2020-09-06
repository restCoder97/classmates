//
//  SignUP.swift
//  ECampus
//
//  Created by Bill Chen on 9/3/20.
//  Copyright © 2020 Youxing Chen. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class signUp:UIViewController, MFMailComposeViewControllerDelegate{
    var btNext=UIButton(type:.custom);
    var btBack = UIButton(type:.custom);
    var tfEmail = UITextField();
    var PassWord = UITextField();
    var RePassWord = UITextField();
    var btHelp = UIButton();
    let H = UIScreen.main.bounds.size.height
    let W = UIScreen.main.bounds.size.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ////////////////////////////Two Buttons;////
        btBack.setImage(UIImage(named: "back.PNG"), for: .normal)
        btNext.setImage(UIImage(named: "next.PNG"), for: .normal)
        btNext.frame = getRect(x: 173 , y: 562, w: W/5, h: W/5)
        btBack.frame = getRect(x: 57, y: 60, w: 16, h: 27.27);
        self.btNext.backgroundColor = UIColor.white;
        btNext.layer.cornerRadius = 0.5 * btNext.bounds.size.width
        btNext.clipsToBounds = true
        self.btBack.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        self.btNext.addTarget(self, action: #selector(doNext), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btBack);
        self.view.addSubview(btNext);
        
        mainBackColor()//self .background color;
        ///////////////////line Edit
        self.tfEmail = WGT().tfGenerator(position: getRect(x: 57, y: 265, w: 300, h: 55), text: "email", fatherView: self.view, dNum: false, Num: false, PassWord: false)
        self.PassWord = WGT().tfGenerator(position: getRect(x: 57, y: 345, w: 300, h: 55), text: "Enter your password", fatherView: self.view, dNum: false, Num: false, PassWord: true)
        self.RePassWord = WGT().tfGenerator(position: getRect(x: 57, y: 425, w: 300, h: 55), text: "Confirm your password", fatherView: self.view, dNum: false, Num: false, PassWord: true)
        /////////////////////HELP BUTTON////////////
        self.btHelp = WGT().btGenerate(textColor: UIColor.white, backColor: UIColor.init(white: 1, alpha: 0), title: "Need help?", fatherView: self.view, position: getRect(x: 174, y: 822, w: 67, h: 15));
        self.btHelp.titleLabel?.font = UIFont.systemFont(ofSize: 10)

    }
    
    func sendEmail() {
        /*let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://www.example.com")
        // The sign-in operation has to always be completed in the app.
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)*/
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["youxing.chen@go.shoreline.edu"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func random5disgitnumber()->Int{
        let number = Int.random(in: 10000...99999);
        
        return number;
        
    }
    
    func mainBackColor(){
        
        let topColor = UIColor(red: 85/255, green: 1, blue: 196/255, alpha: 1)
        let buttomColor = UIColor(red: 88/255, green: 124/255, blue: 221/255, alpha: 1)
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = self.view.frame
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    func getRect(x:CGFloat,y:CGFloat,w:CGFloat,h:CGFloat)->CGRect{
        return CGRect(x:x/414*W,y:y/896*H,width:W*w/414,height:H*h/896);
    }
    
    @objc func doNext(){
        
        let userEmailAddess:String = tfEmail.text!;
        let code = random5disgitnumber();
        let secPage = signUp2()
        secPage.modalPresentationStyle = .fullScreen;
        secPage.father = self;
        sendEmail();
        self.present(secPage,animated: false)
    }
    
    
    
    @objc func back(){
        self.dismiss(animated: false, completion: nil)
    }
}

class transport{
    
}
class signUp2:signUp{
    var father:UIViewController?
    override func viewDidLoad() {
        ////////////////////////////Two Buttons;////
        btBack.setImage(UIImage(named: "back.PNG"), for: .normal)
        btBack.frame = getRect(x: 57, y: 60, w: 16, h: 27.27);
        self.btNext = WGT().btGenerate(textColor: UIColor.init(red: 86/255, green: 207/255, blue: 205/255, alpha: 1), backColor: UIColor.white, title: "Login", fatherView: self.view, position: getRect(x: 57, y: 515, w: 300, h: 55))
        self.btBack.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        self.btNext.addTarget(self, action: #selector(doNext), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btBack);
        self.view.addSubview(btNext);
        
        mainBackColor()//self .background color;
        ///////////////////line Edit
        self.tfEmail = WGT().tfGenerator(position: getRect(x: 57, y: 300, w: 300, h: 55), text: "User Name", fatherView: self.view, dNum: false, Num: false, PassWord: false)
        self.PassWord = WGT().tfGenerator(position: getRect(x: 57, y: 380, w: 300, h: 55), text: "Chose your school", fatherView: self.view, dNum: false, Num: false, PassWord: true)
        /////////////////////HELP BUTTON////////////
        self.btHelp = WGT().btGenerate(textColor: UIColor.white, backColor: UIColor.init(white: 1, alpha: 0), title: "Can't find your school", fatherView: self.view, position: getRect(x: 207, y: 445, w: 139, h: 15));
        self.btHelp.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.btHelp = WGT().btGenerate(textColor: UIColor.white, backColor: UIColor.init(white: 1, alpha: 0), title: "Need help?", fatherView: self.view, position: getRect(x: 174, y: 822, w: 67, h: 15));
        self.btHelp.titleLabel?.font = UIFont.systemFont(ofSize: 10)

    }
    override func doNext() {
        
        self.dismiss(animated: false, completion: {
            self.father?.dismiss(animated: false, completion: nil);
        });
        
        
    }
    override func back() {
        self.dismiss(animated: false, completion: nil)
    }
    
}
