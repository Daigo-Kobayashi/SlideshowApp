//
//  ResultViewController.swift
//  SlideshowApp
//
//  Created by 小林大悟 on 2020/06/23.
//  Copyright © 2020 daigo.kobayashi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
     // 遷移先に渡したい値を格納する変数を用意
    var selectedImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//----------------------------------------------------------
        
        //ImageViewに画像を設定
        
        imageView.image = selectedImg
    }
    //戻る
    
    @IBAction func backBton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
          
    }
    //ResultViewController
    @IBAction func onTapAction(_ sender: Any) {
       self.performSegue(withIdentifier: "ResultViewController", sender: nil)
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
