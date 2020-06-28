//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 小林大悟 on 2020/06/21.
//  Copyright © 2020 daigo.kobayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!//戻る
    @IBOutlet weak var nextButton: UIButton! //進む
    @IBOutlet weak var switchButton: UIButton! //再生。停止
    
    //一定の間隔で処理を行うためのタイマー
    var timer: Timer!
    // タイマー用の時間のための変数
    var timer_sec: Float = 0
//----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    //初期画面
    //バンドルした画像ファイルを読み込み
    // Image Viewに画像を設定
    let image = UIImage(named: "IMG_01.jpg")
    imageView.image = image
}
//----------------------------------------------------------
    //表示している画像の番号
    var displayImageNo = 0
    //画像の名前の配列
    let imageNameArray = ["IMG_01.jpg", "IMG_02.jpg", "IMG_03.jpg", "IMG_04.jpg", "IMG_05.jpg", "IMG_06.jpg"]
    //表示している画像の番号を元に画像を表示する
    func displayImage(){
        //表示している画像の番号から名前を取り出し
        let name = imageNameArray[displayImageNo]
        //画像を読み込み
        let image = UIImage(named: name)
        // ImageViewに読み込んだ画像をセット
        imageView.image = image
    }
//---------------------------------------------------------


//---------------------------------------------------------
    //タップした場合
    //進むボタン
     @IBAction func nextButtonTap(_ sender: Any) {
          //進むボタンの内容を行う
          if displayImageNo < imageNameArray.count - 1{
              //表示している画像の番号を1増やす
              displayImageNo += 1
              //表示している画像の番号を元に破像を表示する
              displayImage()
          }else{
              displayImageNo = 0
              displayImage()
          }
      }
    
//---------------------------------------------------------
    //戻るボタン
    @IBAction func backButtonTap(_ sender: Any) {
        if displayImageNo >= 1 && displayImageNo <= imageNameArray.count - 1 {
             //表示している画像の番号を1減らす
             displayImageNo -= 1
             //表示している画像の番号を元に画像を表示する
             displayImage()
         }else{
             displayImageNo = imageNameArray.count - 1
             displayImage()
         }
    }
//---------------------------------------------------------
//再生・停止ボタン
    @IBAction func switchButtonTap(_ sender: Any) {
        //動作中のタイマーを一つに保つために、tmerが存在しない場合だけタイマーをせいせいして動作させる
        if self.timer == nil{
            //タイマーを設定(2.0秒）
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self,  selector:
                    #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            //再生・停止ボタンタップ時に進むボタン・戻るボタンのタップ非表示
            nextButton.isEnabled = false
            backButton.isEnabled = false
            //ボタンの名前を停止とする
            switchButton.setTitle("停止", for: .normal)
            //背景色・ボタン内テキストサイズを変更
            self.view.backgroundColor = UIColor.lightGray
            switchButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)

            }else if self.timer != nil{
                //タイマーを停止
                self.timer.invalidate()
                //nilにして再び（nil の時にタイマー生成
                self.timer = nil
                //再生・停止ボタンタップ時に進むボタン・戻るボタンのタップ非表示
                nextButton.isEnabled = true
                backButton.isEnabled = true
                //ボタンの名前を再生とする
                switchButton.setTitle("再生", for: .normal)
                //背景色・ボタン内テキストサイズを戻す
                self.view.backgroundColor = UIColor.white
                switchButton.titleLabel?.font =
                    UIFont.systemFont(ofSize: 20)
            }
    }
    
 //#selectorで呼び出される関数
 @objc func updateTimer(_ timer: Timer){
    //進むボタンの内容を行う
    if displayImageNo < imageNameArray.count - 1{
        //表示している画像の番号を1増やす
        displayImageNo += 1
        //表示している画像の番号を元に破像を表示する
        displayImage()
    }else{
        displayImageNo = 0
        displayImage()
    }
}
    //遷移先から戻るsegueを設定
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
       }
    @IBAction func onTapAction(_ sender: Any) {
        // タイマーを停止する
        if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil          // startTimer()のself.timer == nilで判断するために、self.timer =　nilとしておく
            switchButton.setTitle("再生", for: .normal)//ボタンを再生に戻す
            nextButton.isEnabled = true //trueに置き換える
            backButton.isEnabled = true
            }
        print("onTapAction")//デバッグ用
        
       self.performSegue(withIdentifier: "result", sender: nil)
        
    }
     // 遷移元から遷移先にデータ(画像)を渡す
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            // segueから遷移先のResultViewControllerのインスタンスを取得する
            let resultViewController:ResultViewController = segue.destination as! ResultViewController
            // 表示している画像の番号から名前を取り出し
            let name = imageNameArray[displayImageNo]
            // 画像を読み込み
            let image = UIImage(named: name)
            
    // 遷移先のResultViewControllerで宣言しているselectedImgに値を代入して渡す
            resultViewController.selectedImg = image
            
            
            
            
            
        }
}
