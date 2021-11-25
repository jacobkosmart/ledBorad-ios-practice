//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by Jacob Ko on 2021/11/25.
//

import UIKit

// delegate pattern : 이전화면에서 설정된 값들을 앞 페이지로 전달하기
protocol LEDBoardSettingDelegate: AnyObject {
	func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {
	
	// TextFiled 연결
	@IBOutlet weak var textField: UITextField!
	
	// Text Colors 연결
	@IBOutlet weak var yellowBtn: UIButton!
	@IBOutlet weak var purpleBtn: UIButton!
	@IBOutlet weak var greenBtn: UIButton!
	
	// Background Colors 연결
	@IBOutlet weak var blackBtn: UIButton!
	@IBOutlet weak var blueBtn: UIButton!
	@IBOutlet weak var orangeBtn: UIButton!
	
	// delegate 변수
	weak var delegate: LEDBoardSettingDelegate?
	
	// 저장되고 앞에서 다시 설정할때 앞페이지에서 값을 받을 수 있게 변수 설정
	var ledText: String?
	
	// 초기화 값 설정
	var textColor: UIColor = .yellow
	var backgroundColor: UIColor = .black
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// led 화면에서 받은값이 페이지 로드 될때 불러오기
		self.configureView()
	}
	
	// 앞에서 전달 받은 데이터들로 view 를 초기화 하기
	private func configureView() {
		if let ledText = self.ledText {
			self.textField.text = ledText
		}
		self.changeTextColor(color: self.textColor)
		self.changeBackgroundColor(color: self.backgroundColor)
	}
	
	@IBAction func tabTextColorBtn(_ sender: UIButton) {
		if sender == self.yellowBtn {
			self.changeTextColor(color: .yellow)
			self.textColor = .yellow
		} else if sender == self.purpleBtn {
			self.changeTextColor(color: .purple)
			self.textColor = .purple
		} else {
			self.changeTextColor(color: .green)
			self.textColor = .green
		}
	}
	
	@IBAction func tabBackgroundColorBtn(_ sender: UIButton) {
		if sender == self.blackBtn {
			self.changeBackgroundColor(color: .black)
			self.backgroundColor = .black
		} else if sender == self.blueBtn {
			self.changeBackgroundColor(color: .blue)
			self.backgroundColor = .blue
		} else {
			self.changeBackgroundColor(color: .orange)
			self.backgroundColor = .orange
		}
	}
	
	// 설정 된 delegate 값을 Save 버튼 누르면 보내는 logic
	@IBAction func tabSaveButton(_ sender: UIButton) {
		self.delegate?.changedSetting(
			text: self.textField.text,
			textColor: self.textColor,
			backgroundColor: self.backgroundColor
		)
		// 이전화면으로 이동
		self.navigationController?.popViewController(animated: true)
	}
	
	// 선택된 color는 alpha 값을 1로 하고 선택되지 않은 color 는 alpha 를 0.2로 설정
	private func changeTextColor(color: UIColor) {
		self.yellowBtn.alpha = color == UIColor.yellow ? 1 : 0.2
		self.purpleBtn.alpha = color == UIColor.purple ? 1 : 0.2
		self.greenBtn.alpha = color == UIColor.green ? 1 : 0.2
	}
	private func changeBackgroundColor(color: UIColor) {
		self.blackBtn.alpha = color == UIColor.black ? 1 : 0.2
		self.blueBtn.alpha = color == UIColor.blue ? 1 : 0.2
		self.orangeBtn.alpha = color == UIColor.orange ? 1 : 0.2
	}
}
