//
//  NasaViewController.swift
//  AppAll
//
//  Created by Роман Романов on 10.03.2023.
//

import UIKit

class NasaViewController: UIViewController {
    //MARK: - Propertys
    
    let nasaImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let nasaTitleLable: UILabel = {
        let lable = UILabel()
        
        lable.font = .systemFont(ofSize: 20, weight: .bold)
        lable.numberOfLines = 0
        
        return lable
    }()
    
    let explanationTextView: UITextView = {
        let textView = UITextView()
        
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    let urlLable: UILabel = {
        let lable = UILabel()
        
        lable.font = .systemFont(ofSize: 16)
        lable.numberOfLines = 0
        
        return lable
    }()
    
    let dateLable: UILabel = {
        let lable = UILabel()
        
        lable.font = .systemFont(ofSize: 16)
        
        return lable
    }()
    
    let autorLable: UILabel = {
        let lable = UILabel()
        
        lable.font = .systemFont(ofSize: 16)
        
        return lable
    }()
    
    //MARK: - Live metods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(nasaImage)
        self.view.addSubview(nasaTitleLable)
        self.view.addSubview(explanationTextView)
        self.view.addSubview(urlLable)
        self.view.addSubview(dateLable)
        self.view.addSubview(autorLable)
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 5
        let widthViews = self.view.bounds.size.width - (margin * 2)
        let topPadding = (UIApplication.shared.windows[0].safeAreaInsets.top) + (self.navigationController?.toolbar.bounds.size.height ?? 0)
        let heightImage: CGFloat = 200
        let heightLable: CGFloat = 150
        
        nasaImage.frame = CGRect(x: margin,
                                 y: topPadding,
                                 width: widthViews,
                                 height: heightImage)
        
        nasaTitleLable.frame = CGRect(x: margin,
                                      y: nasaImage.frame.size.height + topPadding + margin,
                                      width: widthViews,
                                      height: heightLable)
        nasaTitleLable.sizeToFit()
        
        explanationTextView.frame = CGRect(x: margin,
                                           y: nasaTitleLable.frame.size.height + nasaImage.frame.size.height + topPadding + (margin * 2),
                                           width: widthViews,
                                           height: heightLable)
        explanationTextView.sizeToFit()
        
        urlLable.frame = CGRect(x: margin,
                                y: explanationTextView.frame.origin.y + explanationTextView.frame.size.height + margin,
                                width: widthViews,
                                height: heightLable)
        urlLable.sizeToFit()
        
        autorLable.frame = CGRect(x: margin,
                                  y: urlLable.frame.origin.y + urlLable.frame.size.height + margin,
                                  width: (widthViews / 2) - (margin / 2),
                                  height: heightLable)
        autorLable.sizeToFit()
        
        dateLable.frame = CGRect(x: autorLable.frame.size.width + margin + (margin / 2),
                                 y: urlLable.frame.origin.y + urlLable.frame.size.height + margin,
                                 width: (widthViews / 2) - (margin / 2),
                                 height: heightLable)
        dateLable.sizeToFit()
    }
    
    //MARK: - Setting metods
    
    func setPropertys(image: UIImage, title: String, url: String, date: String, autor: String, explanation: String) {
        self.nasaImage.image = image
        self.nasaTitleLable.text = title
        self.urlLable.text = url
        self.dateLable.text = date
        self.autorLable.text = autor
        self.explanationTextView.text = explanation
    }
}
