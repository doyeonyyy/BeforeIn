//
//  DetailViewController.swift
//  BeforeIn
//
//  Created by t2023-m079 on 10/11/23.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    private let detailView = DetailView()
    var selectedEtiquette: Etiquette?

    // MARK: - Life Cycle
    override func loadView(){
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupAddTarget()
        setUI()
        
        if let selectedEtiquette = selectedEtiquette {
            print("선택된 에티켓 ", selectedEtiquette)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCollectionView()
    }
    
    // MARK: - Methods
    func setupAddTarget(){
        /// firstDetailView
        detailView.firstDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func configureCollectionView() {
        /// secondDetailView
        detailView.secondDetailView.dontsCollectionView.register(EtiquetteDetailCell.self, forCellWithReuseIdentifier: "EtiquetteDetailCell")
        detailView.secondDetailView.dontsCollectionView.dataSource = self
        detailView.secondDetailView.dontsCollectionView.delegate = self
        /// thirdDetailView
        detailView.thirdDetailView.dosCollectionView.register(EtiquetteDetailCell.self, forCellWithReuseIdentifier: "EtiquetteDetailCell")
        detailView.thirdDetailView.dosCollectionView.dataSource = self
        detailView.thirdDetailView.dosCollectionView.delegate = self
    }
    
    private func setUI() {
        /// firstDetailView
        detailView.firstDetailView.titleLabel.text = "\(selectedEtiquette?.place ?? "place") 에티켓 알아보기"
        detailView.firstDetailView.descriptionLabel.text = "\(selectedEtiquette?.place ?? "place")에서 지켜야할 기본 규칙을 알아봅시다"
//        detailView.firstDetailView.detailImageView.image = selectedEtiquette?.backgroundImage
        if let image = selectedEtiquette?.backgroundImage {
            let maskedImage = applyMask(to: image)
            detailView.firstDetailView.detailImageView.image = maskedImage
        }
        /// secondDetailView
        detailView.secondDetailView.etiquetteTotalCountLabel.text = "/\(selectedEtiquette?.content["good"]?.count ?? 0)"
        /// thirdDetailView
        detailView.thirdDetailView.etiquetteTotalCountLabel.text = "/\(selectedEtiquette?.content["bad"]?.count ?? 0)"

    }

    private func applyMask(to image: UIImage) -> UIImage {
        if let cgImage = image.cgImage {
            let width = cgImage.width
            let height = cgImage.height
            let bitsPerComponent = 8
            let bytesPerRow = 4 * width
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

            if let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) {
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
                context.clip(to: CGRect(x: 0, y: 0, width: width, height: height))
                context.setFillColor(UIColor(white: 0, alpha: 0.7).cgColor)
                context.fill(CGRect(x: 0, y: 0, width: width, height: height))

                if let maskedImage = context.makeImage() {
                    return UIImage(cgImage: maskedImage)
                }
            }
        }
        return image
    }
    
    
    // MARK: - @objc
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
   
}

// MARK: - CollectionView
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailView.secondDetailView.dontsCollectionView {
            /// dontsCollectionView 내용
            return selectedEtiquette?.content["good"]?.count ?? 0
        } else if collectionView == detailView.thirdDetailView.dosCollectionView {
            /// dosCollectionView 내용
            return selectedEtiquette?.content["bad"]?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EtiquetteDetailCell", for: indexPath) as! EtiquetteDetailCell

        if collectionView == detailView.secondDetailView.dontsCollectionView {
            /// dontsCollectionView 내용
            cell.backgroundColor = .clear
            if let etiquette = selectedEtiquette {
                cell.titleLabel.text = etiquette.content["bad"]?[indexPath.item].mainContent
                cell.descriptionLabel.text = etiquette.content["bad"]?[indexPath.item].subContent
                cell.backgroundImage.image = etiquette.content["bad"]?[indexPath.item].contentImage
            }
        } else if collectionView == detailView.thirdDetailView.dosCollectionView {
            /// dosCollectionView 내용
            cell.backgroundColor = .clear
            if let etiquette = selectedEtiquette {
                cell.titleLabel.text = etiquette.content["good"]?[indexPath.item].mainContent
                cell.descriptionLabel.text = etiquette.content["good"]?[indexPath.item].subContent
                cell.backgroundImage.image = etiquette.content["good"]?[indexPath.item].contentImage
            }
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == detailView.secondDetailView.dontsCollectionView {
            let collectionViewCenterX = scrollView.center.x + scrollView.contentOffset.x
            let centerCellIndex = Int(collectionViewCenterX / scrollView.frame.width)
            detailView.secondDetailView.etiquetteCountLabel.text = String(centerCellIndex + 1)
        }
        if scrollView == detailView.thirdDetailView.dosCollectionView {
            let collectionViewCenterX = scrollView.center.x + scrollView.contentOffset.x
            let centerCellIndex = Int(collectionViewCenterX / scrollView.frame.width)
            detailView.thirdDetailView.etiquetteCountLabel.text = String(centerCellIndex + 1)
        }
    }
}
