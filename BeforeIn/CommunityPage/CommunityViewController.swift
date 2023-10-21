


import UIKit
import SnapKit

class CommunityViewController: UIViewController {
    
    let customView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1).cgColor
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "전체보기"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        return label
    }()
    
    let customView2: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1).cgColor
        return view
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "요즘 문화"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        return label
    }()
    
    let customView3: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1).cgColor
        return view
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "우리끼리"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        return label
    }()
    
    let customView4: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1).cgColor
        return view
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.text = "교통"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        return label
    }()
    
    let shadowView1: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelText: UILabel = {
        let label = UILabel()
        label.text = "요즘 애들은 지하철 노약자석에 그냥 앉아 있나요?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let tagRectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tagRectangleView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.616, green: 0.102, blue: 0.102, alpha: 1)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nicknamelabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 • 1일 전"
        label.textColor = UIColor(red: 0.396, green: 0.396, blue: 0.396, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let taglabel: UILabel = {
        let label = UILabel()
        label.text = "교통"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let taglabel2: UILabel = {
        let label = UILabel()
        label.text = "요즘 문화"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let heartIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    let heartLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = UIColor(red: 0.396, green: 0.396, blue: 0.396, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let commemtIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "text.bubble"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    let commemLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = UIColor(red: 0.396, green: 0.396, blue: 0.396, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 35
        view.backgroundColor = UIColor(red: 1, green: 0.504, blue: 0.504, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let shadowView2: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plusIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label4)
        view.addSubview(shadowView1)
        view.addSubview(rectangleView)
        view.addSubview(customView)
        customView.addSubview(label)
        view.addSubview(customView2)
        customView2.addSubview(label2)
        view.addSubview(customView3)
        customView3.addSubview(label3)
        view.addSubview(customView4)
        rectangleView.addSubview(labelText)
        rectangleView.addSubview(nicknamelabel)
        rectangleView.addSubview(tagRectangleView)
        rectangleView.addSubview(tagRectangleView2)
        tagRectangleView.addSubview(taglabel)
        tagRectangleView2.addSubview(taglabel2)
        rectangleView.addSubview(heartIcon)
        rectangleView.addSubview(commemtIcon)
        view.addSubview(heartLabel)
        view.addSubview(commemLabel)
        view.addSubview(circleView)
        view.addSubview(shadowView2)
        view.addSubview(plusIcon)
        
        plusIcon.isUserInteractionEnabled = true
                let plusIconTapGesture = UITapGestureRecognizer(target: self, action: #selector(plusIconTapped))
                plusIcon.addGestureRecognizer(plusIconTapGesture)
        
        customView.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(62)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(customView)
        }
        
        customView2.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(32)
            make.left.equalTo(customView.snp.right).offset(8)
            make.top.equalToSuperview().offset(62)
        }

        label2.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(customView2)
        }
        
        customView3.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(32)
            make.left.equalTo(customView2.snp.right).offset(8)
            make.top.equalToSuperview().offset(62)
        }
        
        label3.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(customView3)

        }
        
        customView4.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.height.equalTo(32)
            make.left.equalTo(customView3.snp.right).offset(8)
            make.top.equalToSuperview().offset(62)
        }
        
        label4.snp.makeConstraints { make in
            make.leading.equalTo(label3.snp.trailing).offset(56)
            make.top.equalToSuperview().offset(64)
            
        }
        
        rectangleView.snp.makeConstraints { make in
            make.width.equalTo(361)
            make.height.equalTo(140)
            make.centerX.equalToSuperview()
            make.top.equalTo(label3.snp.bottom).offset(32)
        }
        
        labelText.snp.makeConstraints { make in
            make.width.equalTo(329)
            make.height.equalTo(44)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(rectangleView.snp.top).offset(16)
        }
        
        nicknamelabel.snp.makeConstraints { make in
            make.width.equalTo(329)
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(labelText.snp.bottom).offset(8)
        }
        
        shadowView1.addSubview(rectangleView)
        rectangleView.snp.makeConstraints { make in
            make.edges.equalTo(shadowView1)
        }
        
        tagRectangleView.snp.makeConstraints { make in
            make.width.equalTo(37)
            make.height.equalTo(19)
            make.trailing.equalTo(tagRectangleView2.snp.leading).offset(-8)
            make.bottom.equalTo(rectangleView.snp.bottom).offset(-16)
        }
        
        tagRectangleView2.snp.makeConstraints { make in
            make.width.equalTo(62)
            make.height.equalTo(19)
            make.trailing.equalTo(rectangleView.snp.trailing).offset(-16)
            make.bottom.equalTo(rectangleView.snp.bottom).offset(-16)
        }
        
        taglabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(tagRectangleView)
        }

        taglabel2.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(tagRectangleView2)
        }
        
        heartIcon.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(26)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(rectangleView.snp.bottom).offset(-16)
        }
        
        heartLabel.snp.makeConstraints { make in
            make.left.equalTo(heartIcon.snp.right).offset(4)
            make.bottom.equalTo(rectangleView.snp.bottom).offset(-16)
        }
        
        commemtIcon.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(26)
            make.left.equalTo(heartIcon.snp.right).offset(32)
            make.bottom.equalTo(rectangleView.snp.bottom).offset(-16)
        }
        
        commemLabel.snp.makeConstraints { make in
            make.left.equalTo(commemtIcon.snp.right).offset(4)
            make.bottom.equalTo(rectangleView.snp.bottom).offset(-16)
        }
        
        circleView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        shadowView2.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.edges.equalTo(shadowView2)
        }
        
        plusIcon.snp.makeConstraints { make in
            make.width.equalTo(38)
            make.height.equalTo(38)
            make.centerX.centerY.equalTo(circleView)
        }

    }
    
    @objc func plusIconTapped() {
        let writeViewController = WriteViewController()
        navigationController?.pushViewController(writeViewController, animated: true)
    }
}

