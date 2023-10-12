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
    private let image = UIImageView().then {
        $0.image = UIImage(systemName: "photo.fill")
        $0.tintColor = .gray
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "타이틀"
        $0.textColor = .black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "설명"
        $0.textColor = .black
       
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

}
