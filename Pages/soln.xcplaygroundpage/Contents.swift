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
return false
}
contains([1,2,3,4,5], target: 5)
