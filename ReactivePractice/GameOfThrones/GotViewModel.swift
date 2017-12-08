//
//  GotViewModel.swift
//  ReactivePractice
//
//  Created by Marcel Chaucer on 12/6/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class GOTViewModel: NSObject {
    
    private var allHouses = [House]() {
        didSet {
            self.housesPipe.input.send(value: ())
            print("Did Set Called")
        }
    }
    
    let housesPipe = Signal<Void, NoError>.pipe()
    
    override init() {
        super.init()
        self.getHouses().on(failed: { error in
            print(error)
        },  value: { [weak self] (houses) in
            if let houses = self?.allHouses {
                self?.allHouses = houses
            }
        }).start()
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> GOTCellViewModel {
        let house = allHouses[indexPath.row]
        let cellViewModel = GOTCellViewModel(house: house)
        return cellViewModel
    }
    
    func getHouseCount() -> Int {
        return allHouses.count
    }
    
    func getHouses() -> SignalProducer<[House], APIError> {
        
        return APIManager.getData(endpoint: "https://anapioficeandfire.com/api/houses").attemptMap({ data in
            
            do {
                let resultWrapper = try JSONDecoder().decode([House].self, from: data)
                self.allHouses = resultWrapper
                return Result(value: self.allHouses)
            }
            catch(let error) {
                print("WHOOPS!!")
                print(error)
                return Result(error: APIError.dataMappingError(error: error))
            }
        })
    }
    
}
