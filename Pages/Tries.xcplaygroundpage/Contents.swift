
public class TrieNode<Key: Hashable>{
    public var key: Key?
    
    public weak var parent: TrieNode?
    
    public var children: [Key: TrieNode] = [:]
    public var isTerminating = false
    
    init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
    
}

public class Trie<CollectionType: Collection> where CollectionType.Element: Hashable{
    public typealias Node = TrieNode<CollectionType.Element>
    
    private let root = Node(key: nil, parent: nil)
    
    public func insert(_ collection: CollectionType){
        var curr = root
        
        for element in collection{
            if curr.children[element] == nil{
                curr.children[element] = Node(key: element, parent: curr)
            }
            curr = curr.children[element]!
        }
        curr.isTerminating = true
    }
    
    public func contains(_ collection: CollectionType)-> Bool{
        var curr = root
        
        for element in collection {
            guard let child = curr.children[element] else {
                return false
            }
            curr = child
        }
        return curr.isTerminating
    }
    public func remove(_ collection: CollectionType){
        var curr = root
        
        for element in collection {
            guard  let child = curr.children[element] else {
                return
            }
            curr = child
        }
        curr.isTerminating = false
        
        while let parent = curr.parent, curr.children.isEmpty && !curr.isTerminating {
            parent.children[curr.key!] = nil
            curr = parent
        }
    }
}

let trieTest = Trie<String>()
trieTest.insert("Saber")
trieTest.contains("Sabe")
