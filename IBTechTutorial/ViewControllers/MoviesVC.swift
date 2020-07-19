//
//  MoviesVC.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import UIKit
import Alamofire

class MoviesVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var pageId = 1
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var favoritesUserDefaultsObserver: NSKeyValueObservation!
    let searchController = UISearchController(searchResultsController: nil)
    var shouldSearchBarSearch: Bool {
        return searchController.searchBar.text!.count > 3
    }
    var isFiltering: Bool {
      return searchController.isActive && shouldSearchBarSearch
    }

    let segueIdentifier = "ShowMovieDetailVC"
    let footerHeight: CGFloat = 70.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
//        registerCollectionViewFooterView()
        registerCollectionviewCell()
        setFavoritesUserDefaultsObserver()
        setupSearchBar()
        getMovies(with: pageId)
    }
    
    func setupSearchBar() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func registerCollectionViewFooterView() {
        let className = String(describing: LoadMoreFooterView.self)
        collectionView.register(UINib(nibName: className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }

    func registerCollectionviewCell() {
        let cellName = String(describing: MovieCVC.self)
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }

    func setFavoritesUserDefaultsObserver(){
        favoritesUserDefaultsObserver = UserDefaults.standard.observe(\.favorites, changeHandler: { [weak self] (userDefaults, change) in
            guard let self = self else {return}
            
            self.collectionView.reloadData()
        })
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredMovies = movies.filter { (movie: Movie) -> Bool in
        return movie.originalTitle.lowercased().contains(searchText.lowercased())
      }
      
      collectionView.reloadData()
    }

    func getCellHeight(with width: CGFloat) -> CGFloat {
        
        let imageViewHeight = CGFloat(Helper.roundScreenWidth(with: width)) * 1.5 // the image ratio is 1.5
        let cellHeight = imageViewHeight
        
        return cellHeight
    }
    
    //MARK: - Requests
    
    func getMovies(with pageId: Int) {
        let url = Constants.URLs.moviesUrl + String(pageId)
        
        NetworkManager.request(url: url, method: .get, responseType: Movies.self, successCompletion: { [weak self] (response) in
            guard let self = self else {return}
            guard let results = response?.results else {return}
            
            self.movies.append(contentsOf: results)
            self.pageId = pageId
            self.collectionView.reloadData()
        })
    }
    
    func getMovieDetail(with movieId: String) {
        let url = Constants.URLs.baseUrl + movieId + "?language=en-US&api_key=" + Constants.apiKey
        
        NetworkManager.request(url: url, method: .get, responseType: MovieDetail.self, successCompletion: { [weak self] (response) in
            guard let self = self else {return}
            guard let response = response else {return}
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               self.performSegue(withIdentifier: self.segueIdentifier, sender: response)
            }
        })
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let movieDetail = sender as? MovieDetail {
            let destination = segue.destination as! MovieDetailVC
            destination.movieDetail = movieDetail
        }
    }
}

extension MoviesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = String(isFiltering ? filteredMovies[indexPath.row].id : movies[indexPath.row].id)
        getMovieDetail(with: id)
    }
}

extension MoviesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isFiltering {
            return CGSize(width: self.collectionView.frame.width, height: 0.0)
        }
        
        return CGSize(width: self.collectionView.frame.width, height: footerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
          return filteredMovies.count
        }

        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCVC.self), for: indexPath) as! MovieCVC
        cell.configure(with: isFiltering ? filteredMovies[indexPath.row] : movies[indexPath.row])

        return cell
    }
    
    
}

extension MoviesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let className = String(describing: LoadMoreFooterView.self)
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: className, for: indexPath) as! LoadMoreFooterView
        footer.setLoadMoreAction {[weak self] in
            guard let self = self else {return}
            
            self.getMovies(with: self.pageId + 1)
        }
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let columnSpace: CGFloat = 20.0
        let width = (self.collectionView.frame.width - columnSpace) / 2

        return CGSize(width: width, height: getCellHeight(with: width))
    }
}

extension MoviesVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if searchController.isActive {
        filterContentForSearchText(searchController.searchBar.text!)
    }
  }
    
    
    
}
