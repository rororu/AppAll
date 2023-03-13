import UIKit


enum TypeSection: String {
    case factAndJoke = "Facts and Joke"
    //case currency
    case button = "NASA and INFO"
    //case taskForTheDay
    //case univercity
}

class FactAndJokeCell: UITableViewCell {
    //MARK: - Propertys FactAndJokeCell
    
    static let identifire = "1<F>2<A>3<C>4<T>5"
    lazy var cellImageView: UIImageView? = {
        let imageView = UIImageView()
        
        //--- Setting image layer ---
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var cellLableFact: UILabel? = {
        let lable = UILabel()
        
        //--- Setting lable ---
        lable.font = .systemFont(ofSize: 12)
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        
        //--- Setting lable layer ---
        lable.layer.cornerRadius = 10
        lable.clipsToBounds = true
        
        return lable
    }()
    
    lazy var cellLableJoke: UILabel? = {
        let lable = UILabel()
        
        //--- Setting lable ---
        lable.font = .systemFont(ofSize: 12)
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        
        //--- Setting lable layer ---
        lable.layer.cornerRadius = 10
        lable.clipsToBounds = true
        
        return lable
    }()
    //var cellButtonFirst: UIButton?
    //var cellButtonSecond: UIButton?
    //var cellScrollView: UIScrollView?
    
    //MARK: - Live metods
    
    override func layoutSubviews() {
        //--- Propertys ---
        let margin: CGFloat = 10
        let marginLable: CGFloat = 3
        let imageWidth: CGFloat = 150
        let imageHeight: CGFloat = 150
        var lableFirstHeight: CGFloat
        
        //--- Calculations lableFirstHeight ---
        if cellLableJoke != nil && cellImageView != nil {
            lableFirstHeight = (cellImageView?.frame.size.height ?? self.contentView.bounds.height) / 2 - marginLable * 2
        } else {
            lableFirstHeight = self.contentView.bounds.height - (margin * 2) - marginLable
        }
        
        // НУЖНО ПРОВЕСТИ ТРИ ВАРИАНТА ТЕСТОВ ЯЧЕЙКИ
        // НУЖНО ПРОВЕСТИ ТРИ ВАРИАНТА ТЕСТОВ ЯЧЕЙКИ
        
        cellImageView?.frame = CGRect(x: self.contentView.bounds.size.width - imageWidth - margin * 2,
                                      y: self.contentView.bounds.origin.y + margin,
                                      width: imageWidth,
                                      height: imageHeight)
        
        cellLableFact?.frame = CGRect(x: margin,
                                       y: margin + marginLable,
                                       width: (cellImageView?.frame.origin.x ?? self.contentView.bounds.width) - margin * 2,
                                       height: (cellImageView == nil && cellLableJoke != nil) ? lableFirstHeight - margin : lableFirstHeight)
        cellLableFact?.sizeToFit()
        
        cellLableJoke?.frame = CGRect(x: margin,
                                        y: (cellLableFact?.frame.origin.y ?? 0) + (cellLableFact?.frame.size.height ?? 0) + marginLable,
                                        width: (cellImageView?.frame.origin.x ?? self.contentView.bounds.width) - margin * 2,
                                        height: (cellImageView == nil && cellLableFact != nil) ? lableFirstHeight - margin : lableFirstHeight)
        cellLableJoke?.sizeToFit()
    }
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellLableFact!)
        contentView.addSubview(cellLableJoke!)
        contentView.addSubview(cellImageView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setting metods
    
    //--- Setting image ---
    func getCellImageView(imageDog: UIImage) {
        self.cellImageView?.image = imageDog
    }
    
    //--- Setting fact ---
    func getCellLableCatFact(text: String) {
        self.cellLableFact?.text = text
    }
    
    //--- Setting joke ---
    func getCellLableJoke(text: String) {
        self.cellLableJoke?.text = text
    }
    
    
}

class ButtonCell: UITableViewCell {
    //MARK: - Propertys ButtonCell
    
    static let identifire = "1<B>2<U>3<T>4<T>5<O>6<N>7"
    private var nasaModel: NasaModel?
    
    lazy var nasaButton: UIButton? = {
        //--- Create button ---
        let button = UIButton()
        
        //--- Setting button ---
        button.setTitle("NASA", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray4, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        //button.addTarget(nil, action: #selector(touchNasaButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var infoButton: UIButton? = {
        //--- Create button ---
        let button = UIButton()
        
        //--- Setting button ---
        button.setTitle("INFO BY NAME", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray4, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        //button.layer.shadowOpacity = 0.95
        //button.shadowRadius = 20
        //button.shadowOffset = CGRect(width:, height:)
        
        return button
    }()
    
    //MARK: - Live metods
    
    override func layoutSubviews() {
        let margin: CGFloat = 10
        
        nasaButton?.frame = CGRect(x: margin * 2,
                                  y: margin,
                                  width: (contentView.bounds.size.width / 2) - (margin * 2) - (margin / 2),
                                  height: contentView.bounds.size.height - margin * 2)
        
        infoButton?.frame = CGRect(x: (contentView.bounds.size.width / 2) + margin,
                                   y: margin,
                                   width: (contentView.bounds.size.width / 2) - (margin * 2) - (margin / 2),
                                   height: contentView.bounds.size.height - margin * 2)
    }
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nasaButton!)
        contentView.addSubview(infoButton!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setting metods
    
    //@objc private func touchNasaButton(_ sender: UIButton) {
    //    let viewContoller = NasaViewController()
    
    //    guard let nasaModel = self.nasaModel else { return }
    
    //    viewContoller.setPropertys(image: nasaModel.image,
    //                               title: nasaModel.title,
    //                               url: nasaModel.url,
    //                               date: nasaModel.date,
    //                               autor: nasaModel.author,
    //                               explanation: nasaModel.explanation)
    
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    //    print(storyboard.tasks)
    //
    //    let navigationController = storyboard.navigationViewController
    //
    //    print("Touch")
    //    navigationController.pushViewController(viewContoller, animated: true)
    //}
    
    func setNasaModel(model: NasaModel) {
        self.nasaModel = model
    }
}
