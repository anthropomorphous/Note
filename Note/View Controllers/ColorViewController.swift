//
//  ColorViewController.swift
//  Note
//
//  Created by ios_school on 2/7/20.
//  Copyright © 2020 ios_school. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var whiteFieldView: UIView!
    
    @IBOutlet weak var redFieldView: UIView!
    
    @IBOutlet weak var greenFieldView: UIView!
    
    @IBOutlet weak var gradientFieldView: UIImageView!
    
    @IBAction func gardientTapGestureRecognizer( _ sender: Any) {
    gradientFieldView.isUserInteractionEnabled = true
        let antonViewController = AntonViewController()
        present(antonViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteFieldView.layer.borderWidth = 1
        whiteFieldView.layer.borderColor = UIColor.black.cgColor

        redFieldView.layer.borderWidth = 1
        redFieldView.layer.borderColor = UIColor.black.cgColor

        greenFieldView.layer.borderWidth = 1
        greenFieldView.layer.borderColor = UIColor.black.cgColor

        gradientFieldView.layer.borderWidth = 1
        gradientFieldView.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
        
//        let gradientTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer: gradientFieldView)))
//        gradientFieldView.isUserInteractionEnabled = true
//        gradientFieldView.addGestureRecognizer(gradientTapGestureRecognizer)
    }
    
    @IBAction func showAntonViewController(_ vc: UIViewController, sender: Any?) {
        let antonViewController = AntonViewController()
        present(antonViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
