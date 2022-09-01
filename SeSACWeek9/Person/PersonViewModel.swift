//
//  PersonViewModel.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/08/31.
//

import Foundation

class PersonViewModel {
    
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    func fetchPerson(query: String) {
        PersonAPIManger.requestLotto(query: query){ person, error in
            
            guard let person = person else { return }
            dump(person)
            self.list.value = person
        }
    }
    
    var numberOfRowInSection: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
}
