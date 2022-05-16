//
//  ViewController.swift
//  Eyeball
//
//  Created by 澈水 on 2022/5/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var hitBtn = makeHitButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view.addSubview(hitBtn)
        hitBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.bottom.equalToSuperview().offset(-200)
        }
    }
    
    func makeHitButton() -> UIButton {
        let btn = UIButton()
        btn.setTitle("Hit me!", for: .normal)
        btn.setTitleColor(.systemPink, for: .normal)
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 10
        btn.setImage(UIImage(systemName: "personalhotspot.circle"), for: .normal)
        btn.tintColor = .systemPink
        
        var config = UIButton.Configuration.plain()
        config.imagePadding = 10
        config.imagePlacement = .top
        btn.configuration = config
        btn.addTarget(self, action: #selector(hitBtnClicked), for: .touchUpInside)
        return btn
    }
    
    @objc func hitBtnClicked() {
        let alert = UIAlertController(title: "You almost had it!", message: "Your total score is xxx", preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome!", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

