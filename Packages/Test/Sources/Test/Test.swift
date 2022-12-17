import Test2

public struct Test {
    public private(set) var text = "Hello, World!"

    public init() {
        let test2 = Test2()
        print("$$$ test2.number = \(test2.hogeNumber)")
        print("$$$ test2.string = \(test2.fugaString)")
    }
}
