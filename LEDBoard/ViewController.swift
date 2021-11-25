//
//  ViewController.swift
//  LEDBoard
//
//  Created by Jacob Ko on 2021/11/25.
//

import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {
	@IBOutlet weak var contentsLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.contentsLabel.textColor = .yellow
	}
	
	// delegate 된 data 받기(segueway 를 통해서)
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let settingViewController = segue.destination as? SettingViewController {
			settingViewController.delegate = self
			
			// setting 페이지에 다시 값 넘겨 주기
			settingViewController.ledText = self.contentsLabel.text
			settingViewController.textColor = self.contentsLabel.textColor
			settingViewController.backgroundColor = self.view.backgroundColor ?? .black // optional 값이면 .black 으로 설정
		}
	}

	// setting 에서 받은 data 로 view 에 초기화 하기
	func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
		if let text = text {
			self.contentsLabel.text = text
		}
		self.contentsLabel.textColor = textColor
		self.view.backgroundColor = backgroundColor
	}
}

