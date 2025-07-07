//
//  HomeViewTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//

import XCTest
@testable import Sentia

final class HomeViewTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockService: MockFeelingService!

    override func setUp() {
        super.setUp()
        mockService = MockFeelingService()
        viewModel = HomeViewModel(feelingService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testLoadFeelings_setsEmotionGroups() {
        viewModel.loadFeelings()
        XCTAssertFalse(viewModel.emotionGroups.isEmpty)
    }

    func testSelectGroup_togglesIfSameGroup() {
        let group = mockService.mockGroups.first!
        viewModel.selectGroup(group)
        XCTAssertTrue(viewModel.isShowingFeelings)
        viewModel.selectGroup(group)
        XCTAssertFalse(viewModel.isShowingFeelings)
    }

    func testGoToConversation_setsCorrectRoute() {
        let group = mockService.mockGroups.first!
        let feeling = group.feelings.first!
        viewModel.selectGroup(group)
        viewModel.selectFeeling(feeling)
        viewModel.goToConversation()

        guard case let .conversation(g, f) = viewModel.route else {
            return XCTFail("Route should be .conversation")
        }
        XCTAssertEqual(g, group)
        XCTAssertEqual(f, feeling)
    }
}
