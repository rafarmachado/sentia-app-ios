//
//  RootCoordinatorViewModelTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//


import XCTest
@testable import Sentia

final class RootCoordinatorViewModelTests: XCTestCase {
    var viewModel: RootCoordinatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = RootCoordinatorViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialSplashState_isTrue() {
        XCTAssertTrue(viewModel.showSplash)
    }

    func testSplashState_becomesFalseAfterDelay() async {
        viewModel.start()
        
        try? await Task.sleep(nanoseconds: UInt64((1.6) * 1_000_000_000))

        XCTAssertFalse(viewModel.showSplash)
    }
}
