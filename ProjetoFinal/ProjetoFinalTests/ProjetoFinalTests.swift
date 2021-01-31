//
//  ProjetoFinalTests.swift
//  ProjetoFinalTests
//
//  Created by Leticia Sousa Siqueira on 21/01/21.
//

import XCTest
import DetalhesMoedas
@testable import ProjetoFinal

class ProjetoFinalTests: XCTestCase {
    
    var vc: ListaMoedasViewController!
    var vc2: FavoritosViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        vc = ListaMoedasViewController()
        vc.viewDidLoad()
    }
    
    func testExample2() throws {
        vc2 = FavoritosViewController()
        vc2.viewDidLoad()
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
