//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

/// A specialized associative array whose key is a `Tag`.
public struct TagMap<Value> {

    /// Creates an empty `TagMap`.
    public init() {
        valueStorage = .init()
        missingValueIndexStorage = .init()
    }

    // MARK: - TagMap - Storage

    private var valueStorage: ContiguousArray<Value?>

    private var missingValueIndexStorage: ContiguousArray<Tag.Index>
}

extension TagMap {

    // MARK: - TagMap - Value

    /// Returns a `Bool` that indicates whether or not this `TagMap` has a value for the given `Tag`.
    ///
    /// - parameter tag: The `Tag` to determine whether or not this `TagMap` contains the value of.
    ///
    /// - returns: If this `TagMap` has a value for the given for the given `Tag`: `true`. Otherwise: `false`.
    ///
    /// - complexity: **O(1)**
    public func hasValue(forTag tag: Tag) -> Bool {
        value(forTag: tag) != nil
    }

    /// Returns the value (if any) for the given `Tag`.
    ///
    /// - parameter tag: The `Tag` to get the value of.
    ///
    /// - returns: The value in this `TagMap` (if any) for the given `Tag`.
    ///
    /// - complexity: **O(1)**
    public func value(forTag tag: Tag) -> Value? {
        guard tag.index < valueStorage.count else {
            return nil
        }
        return valueStorage[tag.index]
    }

    /// Inserts the given value into this `TagMap`.
    ///
    /// - parameter value: The value to insert into this `TagMap`.
    ///
    /// - returns: A `Tag` for the inserted value.
    ///
    /// - complexity: **O(1)**
    public mutating func insertValue(_ value: Value) -> Tag {
        let tag: Tag
        if let index = missingValueIndexStorage.popLast() {
            tag = Tag(index: index)
        } else {
            valueStorage.append(nil)
            let index = valueStorage.count - 1
            tag = Tag(index: index)
        }
        valueStorage[tag.index] = value
        return tag
    }

    /// Updates the value for the given `Tag` in this `TagMap` with the given value.
    ///
    /// - parameter value: The new value for the given `Tag`.
    ///
    /// - parameter tag: The `Tag` whose value to update.
    ///
    /// - complexity: If the given `Tag` already has a value: **O(1)**.
    ///
    /// Otherwise, if the given `Tag` has never been used by this `TagMap`:
    /// **O(n)**, where **n** is the number of times a value would need to be
    /// inserted into this `TagMap` before the given `Tag` would be returned.
    ///
    /// Otherwise, if the given `Tag` has been used before and then was removed:
    /// **O(m)**, where **m** is the number of times a `Tag` was removed from
    /// this `TagMap` without being used again, before the given `Tag` was
    /// removed from this `TagMap`.
    public mutating func updateValue(_ value: Value, forTag tag: Tag) {
        if hasValue(forTag: tag) {
            valueStorage[tag.index] = value
        } else if tag.index < valueStorage.count {
            guard let missingStorageIndex = missingValueIndexStorage.firstIndex(of: tag.index) else {
                preconditionFailure()
            }
            missingValueIndexStorage.remove(at: missingStorageIndex)
        } else {
            let missingCount = valueStorage.count - tag.index + 1
            valueStorage.append(contentsOf: repeatElement(nil, count: missingCount))
            valueStorage[tag.index] = value
        }
    }

    /// Removes the value for the given `Tag` from this `TagMap`.
    ///
    /// - parameter tag: The `Tag` whose value to remove.
    ///
    /// - complexity: **O(1)**
    public mutating func removeValue(forTag tag: Tag) {
        guard hasValue(forTag: tag) else {
            return
        }
        valueStorage[tag.index] = nil
        missingValueIndexStorage.append(tag.index)
    }
}

extension TagMap {

    // MARK: - TagMap - Convenience

    /// Accesses the value for the given `Tag`.
    ///
    /// Getting the value is equivalent to calling `value(forTag:)`.
    ///
    /// Setting the value is equivalent to calling `removeValue(forTag:)` or `updateValue(_:forTag:)` depending on whether the given value is `nil` or not, respectively.
    ///
    /// - parameter tag: The `Tag` whose value to access.
    ///
    /// - returns: The value for the given `Tag` (if any).
    ///
    /// - complexity: See `value(forTag:)`, `removeValue(forTag:)`,or `updateValue(_:forTag:)` as explained earier.
    public subscript(_ tag: Tag) -> Value? {

        get {
            value(forTag: tag)
        }

        set(maybeValue) {
            if let value = maybeValue {
                updateValue(value, forTag: tag)
            } else {
                removeValue(forTag: tag)
            }
        }
    }
}
