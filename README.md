# LED Board

![Kapture 2021-11-25 at 18 15 10](https://user-images.githubusercontent.com/28912774/143413457-cea812b2-d509-40cc-847c-dcabcc3eb4ac.gif)

## Check Point !

### StackView

- 여러개의 view 를 set 으로 만들어 주는 역활을 함

- 일정한 규칙에 따라서 stack view 안에 움직이는것임

### 이미지 넣기

- 프로젝트 내에 Assets 폴더 내에 Image Set 을 추가하여 1x, 2x, 3x 의 크기의 맞게 해당 이미지를 넣어 줍니다 (24px, 48px, 72px 사이즈의 이미지를 추가함) -> 다양한 크기의 image 를 추가하는것은 iphone, ipad 등 다양한 해상도에서 이미지가 깨지지 않게 하기 위함임

## 주요 코드

![image](https://user-images.githubusercontent.com/28912774/143413082-70bc8417-e3d0-4938-8c98-8f66353d65f8.png)

```swift
// viewController.swift

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
```

```swift
// settingViewController.swift

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

```

## reference

fastcampus - [https://fastcampus.co.kr/dev_online_iosappfinal](https://fastcampus.co.kr/dev_online_iosappfinal)
