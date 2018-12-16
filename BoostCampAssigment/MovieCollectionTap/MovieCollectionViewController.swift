//
//  MovieCollectionViewController.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/7/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //콜렉션 셀아이디
    let cellId = "cellId"
    var movieList: MovieList?
    
    //새로고침 컨트롤러
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMoviesFromJSON(sortingNumber: "0")
        
        collectionView.backgroundColor = .white
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.refreshControl = self.refreshControl
        
        setupNavigationItems()
    }
    
    //새로고침 동작
    @objc func handleRefresh() {
        print("콜렉션뷰 새로고침")
        movieList?.movies.removeAll()
        fetchMoviesFromJSON(sortingNumber: "0")
        self.collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //네비게이션 바
    fileprivate func setupNavigationItems() {
        self.navigationItem.title = "영화목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "GearItem@2x.png"), style: .plain, target: self, action: #selector(handleArrangeButton))
    }
    
    //정렬버튼 동작
    @objc func handleArrangeButton() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "예매율", style: .default, handler: { (_) in
            
            self.fetchMoviesFromJSON(sortingNumber: "0")
            self.navigationItem.title = "예매율순"
            self.collectionView.reloadData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "큐레이션", style: .default, handler: { (_) in
            self.fetchMoviesFromJSON(sortingNumber: "1")
            self.navigationItem.title = "큐레이션순"
            self.collectionView.reloadData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "개봉일", style: .default, handler: { (_) in
            self.fetchMoviesFromJSON(sortingNumber: "2")
            self.navigationItem.title = "개봉일순"
            self.collectionView.reloadData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    //JSON 통신
    fileprivate func fetchMoviesFromJSON(sortingNumber: String?) {
        let sortingNumber = sortingNumber ?? "0"
        
        let jsonUrlString = "http://connect-boxoffice.run.goorm.io/movies?order_type=\(sortingNumber)"
        
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                self.movieList = try decoder.decode(MovieList.self, from: data)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch let jsonErr {
                print("Failed to parsing json \(jsonErr)")
                self.jsonErrAlet()
            }
            
            }.resume()
        
    }
    
    //JSON 에러 알람창
    func jsonErrAlet() {
        let alert = UIAlertController(title: "JSON Errro", message: "데이터를 수신하지 못하였습니다. 인터넷 연결을 확인후 다시 시도해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "재연결", style: .default, handler: { (_) in
            self.handleRefresh()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return movieList?.movies.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCollectionViewCell

        cell.movie = movieList?.movies[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = (view.frame.height) * 2.8/5
        let width = (view.frame.width) / 2 - 10

        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailController = MovieDetailControllerA()
        movieDetailController.movie = self.movieList?.movies[indexPath.row]
        
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
}
