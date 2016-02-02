//
//  ViewController.swift
//  ExpandReduceImage
//
//  Created by Masaki Horimoto on 2016/02/02.
//  Copyright © 2016年 Masaki Horimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageViewFromLibrary: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     Librayボタンを押した時の動作 (写真Libarayにアクセスします)
    */
    @IBAction func pressLibrayButton(sender: AnyObject) {
        
        //print("\(NSStringFromClass(self.classForCoder)).\(__FUNCTION__) is called!")
        
        shiftToImagePickerController()
        
    }

    /**
     ImagePickerControllerに遷移する
    */
    func shiftToImagePickerController() {
        //print("\(NSStringFromClass(self.classForCoder)).\(__FUNCTION__) is called!")
        
        //Libraryにアクセス出来るか確認. 出来なければreturn.
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) else {
            print("Cannot access PhotoLibrary.")
            return
        }
        
        let imagePickerController = UIImagePickerController()   //ImagePickerControllerをインスタンス化
        imagePickerController.delegate = self                   //delegateを自身に設定
        imagePickerController.sourceType = .PhotoLibrary        //カメラとライブラリのどちらを表示するか. 今回はライブラリを表示
        
        //imagePickerControllerに遷移
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String : AnyObject]) {
        print("\(NSStringFromClass(self.classForCoder)).\(__FUNCTION__) is called!")
        
        //ImagePickerControllerで選択した写真にアクセス出来るか確認. 出来なければFatalError.
        guard let image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("originalImage is invalid.")
        }
        
        imageViewFromLibrary.image = image
        imageViewFromLibrary.contentMode = .ScaleAspectFit
        
        //写真選択後にカメラロール表示ViewControllerを引っ込める動作
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }


}

