//
//  AmountPickerPanelViewController.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/15/20.
//

import UIKit
import  FloatingPanel
class AmountPickerPanelViewController: UIViewController {
    static var total = "375"
    
    var selectorSegment:UISegmentedControl = {
    // Initialize
      let items = ["Dollars", "Weight"]
      let customSC = UISegmentedControl(items: items)
      customSC.selectedSegmentIndex = 0

      // Set up Frame and SegmentedControl
//        let frame = UIScreen.main.bounds
//      customSC.frame = CGRectMake(frame.minX + 10, frame.minY + 50,
//                                  frame.width - 20, frame.height*0.1)

      // Style the Segmented Control
      customSC.layer.cornerRadius = 5.0  // Don't let background bleed
      customSC.backgroundColor = K.colors.primaryUIColor
      customSC.tintColor = .white

        let unselectedColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedColor = [NSAttributedString.Key.foregroundColor: K.colors.primaryUIColor]
        customSC.setTitleTextAttributes(unselectedColor, for: .normal)
        customSC.setTitleTextAttributes(selectedColor, for: .selected)
        
      // Add target action method
        customSC.addTarget(self, action: "changeColor:", for: .valueChanged)
                return customSC
    }()
    var midSection:UIStackView = {
        var minusButton:UIButton = {
            var btn = UIButton()
            btn.setTitleColor(K.colors.primaryUIColor, for: .normal)
            btn.setTitle("-", for: .normal)
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.thin)

            
//            btn.backgroundColor = K.colors.primaryUIColor
//            btn.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
//            K.addPrimaryUIButtonStyle(button: btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        var plusbutton:UIButton = {
            var btn = UIButton()
            btn.setTitleColor(K.colors.primaryUIColor, for: .normal)
            btn.setTitle("+", for: .normal)
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.thin)

//            btn.backgroundColor =
//            btn.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
//            K.addPrimaryUIButtonStyle(button: btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        var infoStack:UIStackView = {
            var topText:UILabel = {
                var l = UILabel()
                l.text = "1/2 lb"
                
                l.textColor = K.colors.primaryUIColor
                l.font =  UIFont(name: ".AppleSystemUIFont", size: 25)
                return l
            }()
            var midText:UILabel = {
                var l = UILabel()
                l.text = "$375"
                l.textColor = K.colors.grayUIColor
                l.font =  UIFont(name: ".AppleSystemUIFont", size: 20)
                return l
            }()
            var strainInfo:UIButton = {
                var btn = UIButton()
                btn.setTitleColor(K.colors.primaryUIColor, for: .normal)
                btn.setTitle("Strain Info", for: .normal)
    //            btn.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
//                K.addPrimaryUIButtonStyle(button: btn)
                return btn
                
            }()
            
            
            var s = UIStackView(arrangedSubviews: [topText,midText,strainInfo])
            s.axis = .vertical
            s.distribution = .fillEqually
            s.alignment = .center
            return s
        }()
        
        
        var sv = UIStackView(arrangedSubviews: [minusButton,infoStack, plusbutton])
        sv.distribution  = .fillEqually
        sv.axis = .horizontal
        
        

        
        return sv
    }()
    var addToJarButton:UIButton = {
        var btn = UIButton()
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Add To Jar - $\(total)", for: .normal)
//        btn.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        K.shared.addPrimaryUIButtonStyle(button: btn)
        return btn
    }()
    
    
    
    
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(selectorSegment)
        view.addSubview(midSection)
        view.addSubview(addToJarButton)
        selectorSegment.translatesAutoresizingMaskIntoConstraints = false
        selectorSegment.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        selectorSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        selectorSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        selectorSegment.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        selectorSegment.
        
        midSection.translatesAutoresizingMaskIntoConstraints = false
        midSection.topAnchor.constraint(equalTo: selectorSegment.bottomAnchor, constant: 5).isActive = true
        midSection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        midSection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        midSection.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        addToJarButton.translatesAutoresizingMaskIntoConstraints = false
        addToJarButton.topAnchor.constraint(equalTo: midSection.bottomAnchor, constant: 0).isActive = true
        addToJarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        addToJarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        addToJarButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Do any additional setup after loading the view.
    }
    



}



