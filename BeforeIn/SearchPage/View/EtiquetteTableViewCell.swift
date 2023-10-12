//
//  EtiquetteTableViewCell.swift
//  BeforeIn
//
//  Created by Sanghun K. on 10/12/23.
//

import SnapKit
import Then
import UIKit

class EtiquetteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var image = UIImageView().then {
        $0.image = UIImage(systemName: "photo.fill")
        $0.tintColor = .gray
    }
    
    var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    var titleLabel = UILabel().then {
        $0.text = "타이틀"
        $0.textColor = .black
    }
    
    var descriptionLabel = UILabel().then {
        $0.text = "설명"
        $0.textColor = .black
       
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.lightGray
        
        // addSubview
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(image)
        contentView.addSubview(stackView)
        
        // makeConstraints
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(image).offset(24)
        }
    
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16, bottom: 16, right: 16))
    }

}
