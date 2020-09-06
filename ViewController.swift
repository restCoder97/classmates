//
//  Vie//
//  ViewController.swift
//  Deanza Students Helps
//
//  Created by Bill Chen on 8/19/20.
//  Copyright © 2020 Youxing Chen. All rights reserved.
//

import UIKit

import FacebookLogin
import FBSDKLoginKit
import CoreGraphics
import FacebookCore
import AuthenticationServices


class ViewController: UIViewController, ASAuthorizationControllerDelegate {
    
    
    let H = UIScreen.main.bounds.size.height
    let W = UIScreen.main.bounds.size.width
    var btSignIn=UIButton();
    var btSignUp=UIButton();
    var tfUserName=UITextField();
    var tfPassWord=UITextField();
    var btFrogotPassword = UIButton();
    var lbOr = UILabel();
    var icon:UIImageView?
    var list:[String]=["a","b","ccccccccc","ddddddddddd","eeeeeeeee","FFFFFFFFFFFF"]
    var a:String=""
    var sView = UIView();
    var aTimer :Timer?;
    var btFaceBook = UIButton(type: .custom)
    var btGoogle = UIButton(type: .custom)
    var btApple = UIButton(type: .custom)
    var loginBt = FBLoginButton();
    let authorizationButton = ASAuthorizationAppleIDButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSafeView();
        sView = self.view;
        tfUserName = WGT().tfGenerator(position: CGRect(x:W/7,y:H/3.5,width: W/7*5,height: H/17), text: "   Email/User Name", fatherView: self.sView,dNum: false,Num: false,PassWord: false)
        tfPassWord = WGT().tfGenerator(position: CGRect(x:W/7,y:8.5/20*H-H/21,width: W/7*5,height: H/17), text: "   PassWord", fatherView: self.sView,dNum: false,Num: false,PassWord: true)
        
        
        btSignIn=WGT().btGenerate(textColor: UIColor.black, backColor: UIColor.white, title: "Login", fatherView: self.sView, position: CGRect(x:W/7,y:164.5/340*H+H/10-H/21,width: W/7*5,height: H/17))
        btSignUp = WGT().btGenerate(textColor: UIColor.white, backColor: UIColor.init(red: 1, green: 1, blue: 1, alpha: 0), title: "Sign Up", fatherView: self.sView, position: CGRect(x:W*0.1546,y:0.66*H,width:W/5,height: H/50));
        //CGRect(x:btSignIn.frame.minX,y:btSignIn.frame.maxY+H/50,width:W/5,height: H/50)
        btSignUp.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btFrogotPassword = WGT().btGenerate(textColor: UIColor.white, backColor: UIColor.init(white: 1, alpha: 0), title: "Forgot password?", fatherView: self.sView, position: CGRect(x:W/2,y:btSignUp.frame.minY,width: W*5/14,height: H/50));
        btFrogotPassword.titleLabel?.font = UIFont.systemFont(ofSize: 10)

        btSignIn.addTarget(self, action: #selector(signInDown), for: UIControl.Event.touchUpInside)
        btSignUp.addTarget(self, action: #selector(signUpDown), for: UIControl.Event.touchUpInside)
        //////////
        self.lbOr = WGT().labelGenerator(position: CGRect(x:0,y:btSignUp.frame.minY+H/7 ,width: W,height: H/20), text: "———  OR  ———", fatherView: self.sView, txtColor: UIColor.white, bKColor: UIColor.init(white: 1, alpha: 0));
        lbOr.textAlignment=NSTextAlignment.center
        lbOr.font = UIFont(name: "a", size: 10);
        self.sView.addSubview(lbOr);
        //////////////////////////////
        btFaceBook = WGT().rountdPicBt(pic: UIImage(named: "logoFacebook.PNG")!, pos: CGRect(x:W/2-W/5,y:lbOr.frame.maxY,width: W/6,height: W/6), fatherView: self.sView);
        btFaceBook.backgroundColor=UIColor.white;
        btFaceBook.imageEdgeInsets=UIEdgeInsets.init(top: 10, left: 7, bottom: -10, right: -7)
        //btFaceBook.imageView?.frame = CGRect(x:5,y:5,width: W/5,height: W/5)
        btApple = WGT().rountdPicBt(pic: UIImage(named: "apple.jpg")!, pos: CGRect(x:W/2+W/30,y:lbOr.frame.maxY,width: W/6,height: W/6), fatherView: self.sView);
        btFaceBook.addTarget(self, action: #selector(btFaceBookDown), for: UIControl.Event.touchUpInside);
        btApple.addTarget(self, action: #selector(btAppleDown), for: UIControl.Event.touchUpInside);
        
        // Do any additional setup after loading the view.
        
        icon = UIImageView.init(frame: CGRect(x:1/3*W,y:0,width:W/3,height:W/3))
        icon!.backgroundColor = UIColor.init(white: 1, alpha: 0);
        self.icon?.image = UIImage(named: "iconDefault.png")
        
        self.sView.addSubview(icon!);
        
        loginBt = FBLoginButton();
        loginBt.center = sView.center;
        loginBt.permissions = ["public_profile", "email", "user_birthday","user_hometown","user_gender","pages_show_list,pages_user_gender"]
        //sView.addSubview(loginBt);
        self.hideKeyboardWhenTappedAround()
        loginBt.addTarget(self, action: #selector(signInDown(sender:)), for: UIControl.Event.touchUpInside)
        mainBackColor()
        
        let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white);
        authorizationButton.addTarget(self, action: #selector(btAppleDown), for: .touchUpInside)
        authorizationButton.frame=btApple.frame;
        authorizationButton.layer.cornerRadius = 0.5 * authorizationButton.bounds.size.width
        authorizationButton.clipsToBounds = true
        self.sView.addSubview(authorizationButton);
        let aSocket = socket(string:"https://serene-lake-65599.herokuapp.com")
        aSocket.downloadJSONFromURl();
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           //performExistingAccountSetupFlows()
       }
    @objc func signUpDown(){
        let aSignUp = signUp();
        aSignUp.modalPresentationStyle = .fullScreen;
        self.present(aSignUp,animated: false);
        /*a = "ABCDE"
        let pk = pickView.init(name:"aPicker",position: CGRect(x:0,y:0,width: 100,height: 100), txtColor: UIColor.white,  data: list, result: &a);
        pk.modalPresentationStyle = .overFullScreen
        self.present(pk,animated: false,completion: nil);*/
    }
    
    @objc func signInDown(sender:FBLoginButton){
        self.aTimer=Timer.scheduledTimer (timeInterval:3,target:self,selector:#selector(oneSec),userInfo:nil, repeats:true)
        let str = sender.titleLabel?.text!
        if (str?.contains("out") == true ){
            icon?.image = UIImage(named: "iconDefault.png")
        }
        aTimer?.fire()
    }
    
    @objc func oneSec(){
        if let token = AccessToken.current,
           !token.isExpired {
            self.tfUserName.text = AccessToken.current?.userID;
            let userIcon = fetchUserIcon();
            saveImage(currentImage: userIcon, persent: 1, imageName: "userIcon");
            saveUserName(isFaceBook:true,infors: ["ID","Name"]);
            icon?.image = userIcon;
            self.aTimer?.invalidate();
        }
        
    }
    
    func fetchUserIcon()->UIImage{
        let userID = AccessToken.current?.userID
        let str = "http://graph.facebook.com/" + userID! + "/picture?type=large"
        let facebookProfileUrl = URL(string: str)
        if let data = NSData(contentsOf: facebookProfileUrl! as URL) {
            icon!.image = UIImage(data: data as Data)
            return UIImage(data: data as Data)!;
        }
        return UIImage(named: "iconDefualt.png")!;
    }
    

    
    func alert(msg:String){
           let alertController = UIAlertController(title: "",
                                                   message: msg,
                                                   preferredStyle: .alert)
           self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
               alertController.dismiss(animated: false, completion: nil)
           }
    }
    func loading(sec:Int){
        let loadView = UIActivityIndicatorView(frame: CGRect(x:W/3,y:H/2,width:W/3,height:W/3));
        loadView.startAnimating()
        self.view.addSubview(loadView)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            loadView.removeFromSuperview()
        }
    }
    
    func readIcon(){
        let fullPath = NSHomeDirectory().appending("/Documents/").appending("selfIcon")
        if let savedImage = UIImage(contentsOfFile: fullPath){
            self.icon?.image = savedImage;
        }
        else{
            self.icon?.image = UIImage(named: "user-male.png")
        }
        let dataNS = NSArray(contentsOfFile:NSHomeDirectory()+"/Documents/defaultUserName.plist")// get date from plist file
        if(dataNS != nil )
        {
            let data = dataNS as![String]
            if(data.count != 0)
            {
                self.tfUserName.text = data[0];
            }
        }
    }
    
    func saveUserName(isFaceBook:Bool,infors:[String]){
        
        if(isFaceBook&&(AccessToken.current) != nil) {
            let request = GraphRequest(graphPath: "me", parameters: ["fields": "name,id,email,birthday,hometown,gender"], httpMethod: HTTPMethod(rawValue: "GET"))
            request.start(completionHandler: { (connection, result, error) in
                let userData = result as! [String:String];
                let name = userData["name"];
                let id = userData["id"];
                let birthday = userData["birthday"];
                let data:[String] = ["FB"+id!,name!,birthday!];
                let filePath:String = NSHomeDirectory() + "/Documents/userInfor.plist"
                print(String(filePath))
                let dataNS:NSArray = data as NSArray;
                dataNS.write(toFile: filePath, atomically: true)
            })
        }
        else{
            let filePath:String = NSHomeDirectory() + "/Documents/userInfor.plist"
            print(String(filePath))
            let dataNS:NSArray = infors as NSArray;
            dataNS.write(toFile: filePath, atomically: true)
        }
    }
    
    private func saveImage(currentImage: UIImage, persent: CGFloat, imageName: String){
     if let imageData = currentImage.jpegData(compressionQuality: persent) as NSData? {
            let fullPath = NSHomeDirectory().appending("/Documents/").appending(imageName)
            imageData.write(toFile: fullPath, atomically: true)
            print("fullPath=\(fullPath)")
        }
    }
    
    
    public func safeAreaFrame() -> CGRect {
        let isIphoneX = UIScreen.main.bounds.height >= 812 ? true : false
        var navigationBarHeight:CGFloat = isIphoneX ? 44 : 20
        var tabBarHeight:CGFloat = isIphoneX ? 34 : 0
        var noNavigationExists = true
        if let navigation = self.navigationController {
            noNavigationExists = false
            navigationBarHeight = navigationBarHeight + CGFloat(navigation.navigationBar.frame.height)
        }
        if let tabBarController = self.tabBarController {
            tabBarHeight = noNavigationExists ? tabBarHeight : 0
            tabBarHeight = tabBarHeight + CGFloat(tabBarController.tabBar.frame.height)
        }
        let frame = CGRect(x: 0, y: navigationBarHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - tabBarHeight - navigationBarHeight)
        return frame
    }
    
    func setUpSafeView(){
        self.sView.frame = safeAreaFrame();
        self.sView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0);
        self.view.addSubview(sView);
    }
    
    @objc func btFaceBookDown(){
        let loginManager = LoginManager();
        if let _ = AccessToken.current{
            loginManager.logOut();
        }
        else{
            loginManager.logIn(permissions: ["public_profile", "email", "user_birthday"], from: self, handler: {
                (result,error) in
                if (error != nil) {
                    print(error!.localizedDescription)
                }
                else{
                    self.aTimer=Timer.scheduledTimer (timeInterval:3,target:self,selector:#selector(self.oneSec),userInfo:nil, repeats:true)
                }
            })
        }
    }
    @objc func btAppleDown(){
        performExistingAccountSetupFlows();
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func mainBackColor(){
        
       let topColor = UIColor(red: 85/255, green: 1, blue: 196/255, alpha: 1)
        let buttomColor = UIColor(red: 88/255, green: 124/255, blue: 221/255, alpha: 1)
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        //color position
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = self.view.frame
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
                // Create an account in your system.
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                var email = appleIDCredential.email
                // For the purpose of this demo app, store the `userIdentifier` in the keychain.
                self.saveUserInKeychain(userIdentifier)
                let givenName = fullName?.givenName
                let lastName = fullName?.familyName
                if email == nil{
                    email = "";
                }
                if fullName != nil{
                    self.saveUserName(isFaceBook: false, infors: ["AP"+userIdentifier,givenName! + " " + lastName!, email!])
                }
                
                
                // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
                //self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
                
            case let passwordCredential as ASPasswordCredential:
            
                // Sign in using an existing iCloud Keychain credential.
                let username = passwordCredential.user
                let password = passwordCredential.password
                
                // For the purpose of this demo app, show the password credential as an alert.
                DispatchQueue.main.async {
                    //self.showPasswordCredentialAlert(username: username, password: password)
                }
                
            default:
                break
        }
    }
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "Restcoder.ECampus", account: "youxing.chen@go.shoreline.edu").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
}

extension UIViewController{
    //隐藏键盘
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//告诉苹果弹窗到哪个window上
        return self.view.window!
    }
}
extension UIImage {
func resizeImage(newWidth: CGFloat) -> UIImage {

    let scale = newWidth / self.size.width
    let newHeight = self.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
} }

extension UIViewController {
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? ViewController {
            loginViewController.modalPresentationStyle = .formSheet
            loginViewController.isModalInPresentation = true
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
}

