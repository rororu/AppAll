import UIKit

class ViewController: UIViewController {
    //MARK: - Propertys
    
    var tasks: [TypeSection: [CellModels]] = [:]
    let typeSectionPosition: [TypeSection] = [.factAndJoke, .button]
    let heightCellInSections = [200, 50]
    lazy var navigationViewController = UINavigationController(rootViewController: self.self)
    
    
    //MARK: - Private metods
    
    //--- Create tableView ---
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    //--- Add info from web ---
    private func getDataTasks() {
        
        for sections in typeSectionPosition {
            
            switch sections {
            case .factAndJoke:
                self.tasks[sections] = []
                
                //--- Write catFact from network ---
                CellApi.shared.getCatFact { value in
                    DispatchQueue.main.async {
                        self.tasks[sections]?.append(value)
                        self.tableView.reloadData()
                    }
                }
                
                //--- Write joke from network
                CellApi.shared.getJoke { value in
                    DispatchQueue.main.async {
                        self.tasks[sections]?.append(value)
                        self.tableView.reloadData()
                    }
                }
                
                //--- Write image from network
                CellApi.shared.getDogImage { value in
                    DispatchQueue.main.async {
                        self.tasks[sections]?.append(value)
                        self.tableView.reloadData()
                    }
                }
            case .button:
                self.tasks[sections] = []
                
                CellApi.shared.getNasa { value in
                    DispatchQueue.main.async {
                        self.tasks[sections]?.append(value)
                        self.tableView.reloadData()
                    }
                }
                //self.tasks[sections]?.append(CatFactModel(fact: ""))
                //let sections = IndexSet(integer: 1)
                //self.tableView.reloadSections(sections, with: .none)
            }
        }
    }
    
    //--- Layer for header ---
    private func getLayerHeader(height: CGFloat) -> CALayer {
        let layerMargin: CGFloat = 3
        
        //--- Add layer ---
        let layer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRect(x: layerMargin,
                                                    y: 0,
                                                    width: tableView.bounds.size.width - layerMargin * 2,
                                                    height: height),
                                byRoundingCorners: [.topRight, .topLeft],
                                cornerRadii: CGSize(width: 30,
                                                    height: 0))
        
        //--- Setting layer ---
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 2
        layer.strokeColor = UIColor.black.cgColor
        
        return layer
    }
    
    //--- Layer for mid cell ---
    private func getMidLayer(height: CGFloat) -> CALayer {
        let layerMargin: CGFloat = 3
        
        //--- Add layer ---
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        //--- Add left line ---
        path.move(to: CGPoint(x: layerMargin,
                              y: 0))
        path.addLine(to: CGPoint(x: layerMargin,
                                 y: height))
        
        //--- Add right line ---
        path.move(to: CGPoint(x: tableView.bounds.size.width - layerMargin,
                              y: 0))
        path.addLine(to: CGPoint(x: tableView.bounds.size.width - layerMargin,
                                 y: height))
        
        //--- Setting layer ---
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 2
        layer.strokeColor = UIColor.black.cgColor
        
        return layer
    }
    
    //--- Layer for last cell ---
    private func getBottomLayer(height: CGFloat) -> CALayer {
        let layerMargin: CGFloat = 3
        
        //--- Create layer and path ---
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        //--- Add path ---
        path.move(to: CGPoint(x: layerMargin, y: 0))
        path.addLine(to: CGPoint(x: layerMargin, y: height - 50))
        path.addArc(withCenter: CGPoint(x: layerMargin + 25, y: height - 30),
                    radius: 25,
                    startAngle: .pi,
                    endAngle: .pi/2,
                    clockwise: false)
        path.addLine(to: CGPoint(x: tableView.bounds.size.width - layerMargin - 50, y: height - 5))
        path.addArc(withCenter: CGPoint(x: tableView.bounds.size.width - layerMargin - 25, y: height - 30),
                    radius: 25,
                    startAngle: .pi/2,
                    endAngle: 0,
                    clockwise: false)
        path.addLine(to: CGPoint(x: tableView.bounds.size.width - layerMargin, y: 0))
        
        //--- Setting layer ---
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 2
        layer.strokeColor = UIColor.black.cgColor
        
        return layer
    }
    
    @objc private func touchNasaButton(_ sender: UIButton) {
        let viewContoller = NasaViewController()
        let taskType = typeSectionPosition[1]
    
        guard let nasaModel = self.tasks[taskType]?.first as? NasaModel else { return }
    
        viewContoller.setPropertys(image: nasaModel.image,
                                   title: nasaModel.title,
                                   url: nasaModel.url,
                                   date: nasaModel.date,
                                   autor: nasaModel.author,
                                   explanation: nasaModel.explanation)
        
        //self.present(viewContoller, animated: true)
        navigationViewController.pushViewController(viewContoller, animated: true)
    }
    
    //MARK: - ViewController metods
    
    override func loadView() {
        super.loadView()
        getDataTasks()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        
        //--- Setting tableView ---
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(FactAndJokeCell.self, forCellReuseIdentifier: FactAndJokeCell.identifire)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifire)
        tableView.backgroundColor = .systemGray4
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = self.view.bounds
    }

}

//MARK: - TableView Metods

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let currnetType = typeSectionPosition[section]
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: tableView.bounds.size.width, height: 50))
        let layer = getLayerHeader(height: headerView.frame.size.height)
        
        let lable = UILabel(frame: CGRect(x: 10,
                                          y: 5,
                                          width: headerView.bounds.size.width - 10,
                                          height: headerView.bounds.size.height - 10))
        
        lable.text = currnetType.rawValue
        lable.font = .systemFont(ofSize: 18, weight: .bold)
        
        headerView.layer.addSublayer(layer)
        headerView.addSubview(lable)
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightCellInSections[indexPath.section])
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskType = typeSectionPosition[indexPath.section]
        
        guard let currentCellModel = tasks[taskType] else {
            return UITableViewCell()
        }
        
        switch taskType {
        case .factAndJoke:
            let cell = tableView.dequeueReusableCell(withIdentifier: FactAndJokeCell.identifire, for: indexPath) as! FactAndJokeCell
            let layer = getBottomLayer(height: cell.contentView.bounds.size.height)
            
            //if tasks[taskType]?.count == indexPath.row {
            //    layer = getBottomLayer(height: cell.contentView.bounds.size.height)
            //} else {
            //    layer = getMidLayer(height: cell.contentView.bounds.size.height)
            //}
            
            for element in currentCellModel {
                if element is CatFactModel {
                    let title = "CAT FACT:\n"
                    cell.getCellLableCatFact(text: title + (element as! CatFactModel).fact)
                }
                
                if element is JokeModel {
                    let title = "JOKE:\n"
                    let setup = (element as! JokeModel).setup
                    let punch = (element as! JokeModel).punchline
                    
                    cell.getCellLableJoke(text: title + "-\(setup) \n -\(punch)")
                }
                
                if element is DogModel {
                    cell.getCellImageView(imageDog: (element as! DogModel).image)
                }
                
            }
            
            
            cell.layer.insertSublayer(layer, at: 0)
            cell.clipsToBounds = true
            
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifire, for: indexPath) as! ButtonCell
            let layer = getBottomLayer(height: cell.contentView.bounds.size.height)
            
            if !currentCellModel.isEmpty {
                print(currentCellModel.count)
                cell.setNasaModel(model: currentCellModel.first as! NasaModel)
                cell.nasaButton?.addTarget(nil, action: #selector(touchNasaButton(_:)), for: .touchUpInside)
            }
            
            cell.layer.insertSublayer(layer, at: 0)
            cell.clipsToBounds = true
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskType = typeSectionPosition[section]
        var result: Int?
        
        switch taskType {
        case .factAndJoke:
            result = 1
        case .button:
            result = 1
        }
        
        return result ?? 0
    }
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    print(tasks)
    //    touchNasaButton()
    //}
}
