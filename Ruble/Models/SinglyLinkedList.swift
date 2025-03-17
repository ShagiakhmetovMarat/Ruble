//
//  SinglyLinkedList.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 17.03.2025.
//

import Foundation

class Node<T> {
    var value: T
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

struct SinglyLinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?

    public var count: Int {
        var count = 0
        var current = head
        
        while current != nil {
            count += 1
            current = current?.next
        }
        
        return count
    }

    public var isEmpty: Bool {
        head == nil
    }

    public init(first: Node<T>? = nil) {
        self.head = first
    }

    mutating func push(_ value: T) {
        head = Node(value: value, next: head)

        if tail == nil {
            tail = head
        }
    }

    mutating func append(_ value: T) {
        let node = Node(value: value)
        tail?.next = node
        tail = node
    }

    mutating func insert(_ value: T, after index: Int) {
        guard let node = node(at: index) else { return }
        node.next = Node(value: value, next: node.next)
    }

    mutating func node(at index: Int) -> Node<T>? {
        var currentIndex = 0
        var currentNode = head

        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }

        return currentNode
    }
}
