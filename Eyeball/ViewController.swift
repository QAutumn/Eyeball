//
//  ViewController.swift
//  Eyeball
//
//  Created by 澈水 on 2022/5/16.
//

import UIKit
import SnapKit
import Foundation

class ViewController: UIViewController {
    lazy var hitBtn = makeHitButton()
    lazy var sliderBar = makeSliderBar()
    lazy var titleLabel = makeTitleLabel()
    lazy var resetBtn = makeResetButton()
    lazy var scoreLabel = makeScoreLabel()
    
    
    var randomNumber: Int = Int.random(in: 1...100) {
        didSet {
            titleLabel.text = "Put the Bull's Eye as close as you can to:\(randomNumber)"
        }
    }
    var totalScore: Int = 0 {
        didSet {
            scoreLabel.text = "Current Score: \(totalScore)"
        }
    }
    var numberOfAttemps: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.addSubview(hitBtn)
        hitBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(70)
            make.bottom.equalToSuperview().offset(-200)
        }
        
        view.addSubview(resetBtn)
        resetBtn.snp.makeConstraints { make in
            make.right.equalTo(hitBtn.snp.left).offset(-30)
            make.centerY.equalTo(hitBtn)
        }
        
        view.addSubview(sliderBar)
        sliderBar.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.1)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview()
        }
        
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.width.lessThanOrEqualToSuperview()
        }
    }
    
    func makeHitButton() -> UIButton {
        let btn = UIButton()
        btn.setTitle("Hit me!", for: .normal)
        btn.setTitleColor(.systemPink, for: .normal)
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 10
        btn.setImage(pointIcon("personalhotspot.circle"), for: .normal)
        btn.tintColor = .systemPink
        
        var config = UIButton.Configuration.plain()
        config.imagePadding = 10
        config.imagePlacement = .top
        btn.configuration = config
        btn.addTarget(self, action: #selector(hitBtnClicked), for: .touchUpInside)
        return btn
    }
    
    func makeSliderBar() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.minimumValueImage = pointIcon("moon.stars")
        slider.maximumValueImage = pointIcon("moon.stars.fill")
        slider.isContinuous = false
        slider.addTarget(self, action: #selector(valueChanged), for: .touchUpInside)
        return slider
    }
    
    func makeTitleLabel() -> UILabel {
        var attributes = [NSAttributedString.Key : Any]()
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 30)
        let string = NSAttributedString(string: "Put the Bull's Eye as close as you can to:\(randomNumber)", attributes: attributes)
        let label = UILabel()
        label.attributedText = string
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    func makeResetButton() -> UIButton {
        let btn = UIButton()
        btn.setImage(pointIcon("arrow.counterclockwise", 30), for: .normal)
        btn.tintColor = .systemPink
        btn.addTarget(self, action: #selector(resetBtnClicked), for: .touchUpInside)
        return btn
    }
    
    func makeScoreLabel() -> UILabel {
        let label = UILabel()
        label.text = "Current Score: \(totalScore)"
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }
    
    @objc func hitBtnClicked() {
        let num = Int(sliderBar.value)
        if num != randomNumber {
            makeAlert("You almost had it! The gap is \(abs(num - randomNumber))!")
            numberOfAttemps -= 1
        } else {
            randomNumber = Int.random(in: 1...100)
            numberOfAttemps = 10
            totalScore += max(0, numberOfAttemps)
            makeAlert("SUCCESSFUL!!!!!!!!!!!!!")
        }
    }
    
    func makeAlert(_ alertTitle: String, _ actionTitle: String = "Awesome!") {
        let alert = UIAlertController(title: alertTitle, message: "Your total score is \(totalScore)", preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc func valueChanged() {
        print(Int(sliderBar.value))
    }
    
    @objc func resetBtnClicked() {
        totalScore = 0
        randomNumber = Int.random(in: 1...100)
    }
    
    func pointIcon(_ iconName: String, _ pointSize: CGFloat = 22) -> UIImage?{
        let config = UIImage.SymbolConfiguration(pointSize: pointSize)
        return UIImage(systemName: iconName, withConfiguration: config)
    }
}

