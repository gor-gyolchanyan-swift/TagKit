//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

/// A two-way associative array whose forward-lookup key and backward-lookup value is `Tag`.
public struct TagSpace<Value>
where Value: Hashable {

    // MARK: - TagSpace

    /// Creates an empty `TagSpace`.
    public init() {
        valueForTag = .init()
        tagForValue = .init()
    }

    private var valueForTag: TagMap<Value>

    private var tagForValue: [Value: Tag]

    /// Accesses the `Tag` for the given value.
    ///
    /// - parameter value: The value whose `Tag` to access.
    ///
    /// - returns: The `Tag` for the given value (if any).
    public subscript(tagFor value: Value) -> Tag? {

        get {
            tagForValue[value]
        }

        set(maybeTag) {
            if let tag = self[tagFor: value] {
                valueForTag.removeValue(forTag: tag)
                tagForValue.removeValue(forKey: value)
            }

            if let tag = maybeTag {
                valueForTag.updateValue(value, forTag: tag)
                tagForValue.updateValue(tag, forKey: value)
            }
        }
    }

    /// Accesses the value for the given `Tag`.
    ///
    /// - parameter tag: The `Tag` whose value to access.
    ///
    /// - returns: The value for the given `Tag` (if any).
    public subscript(valueFor tag: Tag) -> Value? {

        get {
            valueForTag[tag]
        }

        set(maybeValue) {
            if let value = self[valueFor: tag] {
                valueForTag.removeValue(forTag: tag)
                tagForValue.removeValue(forKey: value)
            }

            if let value = maybeValue {
                valueForTag.updateValue(value, forTag: tag)
                tagForValue.updateValue(tag, forKey: value)
            }
        }
    }
}
