//
//  NetworkTests.swift
//  BoxOfficeTests
//
//  Created by kakao on 2023/01/17.
//

import XCTest

final class NetworkTests: XCTestCase {
    let urlSession: URLSessionNetworkServiceProtocol? = URLSessionNetworkService()
    func test_영화_내용_잘_받아_오는_지() {
        guard let urlSession = urlSession else {
            XCTFail()
            return
        }

        let expects = XCTestExpectation(description: "영화 정보 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDetailMovieInfo,
                         queryItems: [QueryKeys.movieCode: "20124079"]) {
            (networkResult: Result<MovieInfoDetailResult, URLSessionNetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                expects.fulfill()
            case .failure(let failure):
                print(failure.localizedDescription)
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
        XCTAssert(true)
    }
    func test_오늘_BoxOffice_잘_받아오는_지() {
        guard let urlSession = urlSession else {
            XCTFail()
            return
        }
        
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDailyBoxOffice,
                         queryItems: [QueryKeys.targetDate: Date.today]) {
            (networkResult: Result<BoxOfficeSearchResult, URLSessionNetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                print(success)
                expects.fulfill()
            case .failure(let failure):
                print(failure.localizedDescription)
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
        XCTAssert(true)
    }
}
