//
//  Copyright (c) 2019 Changbeom Ahn
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
@testable import XMLDocument

final class XMLDocumentTests: XCTestCase {
    let hello = """
        <x a="y">Hello, World!</x>
        """
    
    func testInitWithData() {
        XCTAssertEqual(
            try document(content: hello).rootElement()?.stringValue,
            "Hello, World!")
    }

    func testNodesForXPath() {
        XCTAssertEqual(
            try document(content: hello).nodes(forXPath: "/").first?.stringValue,
            "Hello, World!")
    }
    
    func testReturnsElement() throws {
        let x = try document(content: hello).nodes(forXPath: "/*").first
        XCTAssertEqual(
            (x as? XMLElement)?.attribute(forName: "a")?.stringValue,
            "y")
    }
    
    static var allTests = [
        ("testInitWithData", testInitWithData),
        ("testNodesForXPath", testNodesForXPath),
    ]
    
    func document(content: String) throws -> XMLDocument {
        try XMLDocument(data: content.data(using: .utf8)!, options: 0)
    }
}
