//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

/// Equivalent to a `TagMap`, except with no value.
public struct TagSet {

    /// Creates an empty `TagSet`.
    public init() {
        storage = .init()
    }

    private var storage: TagMap<Void>
}

extension TagSet {

    // MARK: - TagSet - Tag

    /// Returns a `Bool` that indicates whether or not this `TagSet` has the given `Tag`.
    ///
    /// - parameter tag: The `Tag` to determine whether or not this `TagSet` has.
    ///
    /// - returns: If this `TagSet` has the given `Tag`: `true`. Otherwise: `false`.
    ///
    /// - complexity: **O(1)**
    public func hasTag(_ tag: Tag) -> Bool {
        storage.hasValue(forTag: tag)
    }
    
    /// Creates a `Tag` in this `TagSet`.
    ///
    /// - returns: The created `Tag`.
    ///
    /// - complexity: **O(1)**
    public mutating func createTag() -> Tag {
        storage.insertValue(())
    }

    /// Inserts the given `Tag` into this `TagSet`.
    ///
    /// - parameter tag: The `Tag` to insert into this `TagSet`.
    ///
    /// - complexity: If the given `Tag` is already in this `TagSet`: **O(1)**.
    ///
    /// Otherwise, if the given `Tag` has never been in this `TagSet`:
    /// **O(n)**, where **n** is the number of times a `Tag` would need to be
    /// created in this `TagSet` before the given `Tag` would be returned.
    ///
    /// Otherwise, if the given `Tag` has been inserted before and then was
    /// removed: **O(m)**, where **m** is the number of times a `Tag` was
    /// removed from this `TagSet` without being inserted again, before the
    /// given `Tag` was removed from this `TagSet`.
    public mutating func insertTag(_ tag: Tag) {
        storage.updateValue((), forTag: tag)
    }

    /// Removes the given `Tag` from this `TagSet`.
    ///
    /// - parameter tag: The `Tag` to remove.
    ///
    /// - complexity: **O(1)**
    public mutating func removeTag(_ tag: Tag) {
        storage.removeValue(forTag: tag)
    }
}
