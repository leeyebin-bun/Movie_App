//
//  CreateViewController.swift
//  Movie_App
//
//  Created by 이예빈 on 2024/05/22.
//

import UIKit

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImg: UIImageView!
    let imgPickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPickerController.delegate = self
    }
    
    @IBAction func addImgAction(_ sender: Any) {
        // 이미지 소스로 사진 라이브러리 선택
        imgPickerController.sourceType = .photoLibrary
        // 이미지 피커 컨트롤러 실행
        self.present(imgPickerController, animated: true, completion: nil)
    }
}
