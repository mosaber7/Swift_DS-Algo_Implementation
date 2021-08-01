public class TrieNode<Key: Hashable>{
    
    public var key: Key?
    public var parent: TrieNode?
    public var children: [Key: TrieNode] = [:]
    public var isTerminating = false
    
    init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}
public class Trie<collectiontype: Collection> where collectiontype.Element: Hashable{
    
    typealias Node = TrieNode<collectiontype.Element>
    let root = Node(key: nil, parent: nil)
    
    public func insert(_ collection: collectiontype){
        var curr = root
        
        for element in collection {
            if curr.children[element] == nil {
                curr.children[element] = Node(key: element, parent: curr)
            }
            curr = curr.children[element]!
        }
        curr.isTerminating = true
        
    }
    func suggestedProducts(_ products: [String], _ searchWord: String) -> [String] {
        var results = [String]()
        var curr: TrieNode<collectiontype.Element>? = nil
        for (index, _) in searchWord.enumerated(){
            let stringIndex = searchWord.index(searchWord.startIndex, offsetBy: index)
            let substring = searchWord[searchWord.startIndex...stringIndex] as! String
            let resultTuple = contains(substring as! collectiontype)
            curr = resultTuple.1
            guard let result = resultTuple.0 else{
                return []
            }
            if curr!.isTerminating{
                results.append(substring as! String)
            }else {
                
            }
        }
        return results
    }
    
    private func contains(_ collection: collectiontype)-> ([TrieNode<collectiontype.Element>]?, TrieNode<collectiontype.Element>){
        var curr = root
        var result: [TrieNode<collectiontype.Element>] = []
        for element in collection {
            guard let child = curr.children[element] else {
                
                return (nil,curr)
            }
            result.append(child)
            curr = child
        }
        return (result, curr)
    }
    
    
}

func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {
    var trie = Trie<String>()
    for product in products {
        trie.insert(product)
    }
    print(trie)
    return []
}
suggestedProducts(["mo", "saber", "mohamed", "mom"], "m")


func contains(_ arr: [Int], target: Int)->Bool{
    binarySerch(arr, target: target, 0, arr.count-1)
}
private func binarySerch(_ arr: [Int], target: Int, _ low: Int, _ high: Int)->Bool{
    if low >= high {return false}
    let lowIndex = arr.index(arr.startIndex, offsetBy: low)
    let highIndex = arr.index(arr.startIndex, offsetBy: high)
    let middileIndex: Int = lowIndex + highIndex / 2
    
    if arr[middileIndex] == target {return true}
    if target > arr[middileIndex]{
        return binarySerch(arr, target: target, middileIndex, high)
    }else {
        return binarySerch(arr, target: target, low, middileIndex)
    }
}
contains([1,2,3,4,5], target: 5)




public struct Heap<Element: Equatable>{
    private var elements: [Element] = []
    var sort:  (Element, Element)-> Bool
    init(sort: @escaping (Element, Element)-> Bool) {
        self.sort = sort
    }
    var count: Int {
        return elements.count
    }
    
    public func rightChildIndex(of parentIndex: Int)-> Int{
        2*parentIndex + 2
    }
    public func leftChildIndex(of parentIndex: Int)-> Int{
        2*parentIndex + 1
    }
    public func parentindex(of childIndex: Int)-> Int{
        (childIndex - 1) / 2
    }
    public func peak()-> Element?{
        elements.first
    }
    
    public mutating func insert(_ element: Element){
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    private mutating func siftDown(from index: Int){
        var parent = index
        while true {
            let right = rightChildIndex(of: parent)
            let left = leftChildIndex(of: parent)
            var candidate = parent
            if left < count && right < count {
            if sort(elements[left], elements[parent]) && sort(elements[left], elements[right]) {
                candidate = left
            }
            if  sort(elements[right], elements[parent]) && !sort(elements[left], elements[right]) {
                
                candidate = right
                
            }
            }
            
            
            if candidate == parent {return}
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    private mutating func siftUp(from index: Int){
       var child = index
        var parent = parentindex(of: child)
        while child > 0 && sort(elements[child], elements[parent]){
            elements.swapAt(child, parent)
            child = parent
            parent = parentindex(of: child)
        }
    }
    public mutating func remove() -> Element? {
        guard !elements.isEmpty else {
        return nil
          }
          elements.swapAt(0, count - 1)
          defer {
            siftDown(from: 0) // 4
          }
          return elements.removeLast()
    }
}
func lastStoneWeight(_ stones: [Int]) -> Int {
    var heap = Heap<Int>(sort: >)
    
    for stone in stones{
        heap.insert(stone)
    }
    var outputHeap = getlastStoneWeight(heap)
    return outputHeap.remove() ?? 0
}
private func getlastStoneWeight(_ heap: Heap<Int>) -> Heap<Int>{
    var currHeap = heap
    while currHeap.count > 1 {
        
        let max1 = currHeap.remove()!
        let max2 = currHeap.remove()!
       
        if max1 == max2 {continue}
       
        currHeap.insert(max1-max2)
        
    }
    
    return currHeap
}
print(lastStoneWeight([9,3,2,10]))
