
/**
 * `后进先出`，栈中弹出的元素总是你最后放进去的那个
 * 类似于数组，只是限制了存取操作的灵活性。压栈是将元素压入数组尾部
 * 在数组的头部插入元素是一个很耗时的操作，它的时间复杂度为 O(n)，因为需要将现有元素往后移位为新元素腾出空间。而在尾部插入元素的时间复杂度为 O(1)
 * 栈只允许使用者从栈顶压入（push）元素，从栈顶弹出（pop）元素，取得（peek）栈顶元素但不弹出。

 **栈的几个要素：**
  1. 入栈（push）
  2. 出栈（pop）
  3. 取得栈顶元素（peek）
  4. 栈是否为空（isEmpty）
  5. 栈的大小（size）
 */

protocol Stack {
    // 持有元素类型
    associatedtype Element
    
    // 是否为空
    var isEmpty: Bool { get }
    // 栈的大小
    var size: Int { get }
    // 栈顶元素
    var peek: Element? { get }
    
    // 入栈
    mutating func push(_ newElement: Element)
    // 出栈
    mutating func pop() -> Element?
}

struct MyStack<T>: Stack {
    typealias Element = T
    
    private var stack = [Element]()
    
    var isEmpty: Bool {
        return stack.isEmpty
    }
    var size: Int {
        return stack.count
    }
    var peek: Element? {
        return stack.last
    }
    
    mutating func push(_ newElement: Element) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Element? {
        return stack.popLast()
    }
}


var stack = MyStack<Int>()
stack.push(8)
stack.push(6)
stack.push(3)
// [8, 6, 3]

stack.peek // 3
stack.pop()
stack.peek // 6
stack.pop()
stack.peek // 8
stack.pop()
stack.peek // nil


/**
 
 # 队列
 
 `先进先出`,类似于排队买票，先排队的先买票
 
 **队列的几个要素：**
 1. enqueue
 2. dequeue
 3. isEmpty
 4. peek
 5. size
 
 */

protocol Queue {
    // 持有元素类型
    associatedtype Element
    
    // 是否为空
    var isEmpty: Bool { get }
    // 队列的大小
    var size: Int { get }
    // 队首元素
    var peek: Element? { get }
    
    // 入队
    mutating func enqueue(_ newElement: Element)
    // 出队
    mutating func dequeue() -> Element?
}

struct MyQueue<T>: Queue {
    typealias Element = T

    private var left = [Element]()
    private var right = [Element]()
    
    var isEmpty: Bool {
        return left.isEmpty && right.isEmpty
    }
    var size: Int {
        return left.count + right.count
    }
    var peek: Element? {
        return left.isEmpty ? right.first : left.last
    }
    
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    // 取出的时候，因为队列是先进先出，将数组翻转后，类似于栈的操作
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}


var queue = MyQueue<Int>()
queue.enqueue(8)
queue.enqueue(6)
queue.enqueue(3)
queue.enqueue(9)
// [8, 6, 3, 9]

queue.peek // 8
queue.dequeue()
queue.peek // 6
queue.dequeue()
queue.peek // 3
queue.dequeue()
queue.peek // 9
queue.dequeue()
queue.peek // nil


