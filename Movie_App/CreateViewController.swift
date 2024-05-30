//
//  CreateViewController.swift
//  Movie_App
//
//  Created by 이예빈 on 2024/05/22.
//

import UIKit

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleTextField: UITextField!
    
    let imgPickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.doneButton.layer.masksToBounds = true
        self.doneButton.layer.cornerRadius = 6
        self.doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        self.navigationBar.layer.masksToBounds = true
        self.navigationBar.layer.cornerRadius = 15
        
        imgPickerController.delegate = self
    }
    
    /*
     뒤로가기
     */
    @IBAction func OnClickBackButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    /*
     생성완료
     */
    @IBAction func OnClickDoneButton(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier:  "PosterViewController") as? PosterViewController else { return }
        
        //vc.dataDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
        // PosterView 로 이동
        guard let posterVC = self.storyboard?.instantiateViewController(identifier: "PosterView") else { return }
        posterVC.modalTransitionStyle = .coverVertical
        posterVC.modalPresentationStyle = .fullScreen
        
        self.present(posterVC, animated: true, completion: nil)
    }
    
    @IBAction func addImgAction(_ sender: Any) {
        // 이미지 소스로 사진 라이브러리 선택
        imgPickerController.sourceType = .photoLibrary
        // 이미지 피커 컨트롤러 실행
        self.present(imgPickerController, animated: true, completion: nil)
    }
}
