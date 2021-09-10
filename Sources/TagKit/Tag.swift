//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

/// A symbolic identity for an arbitrary value.
///
/// A `Tag` is most motably used as a key for a `TagMap` or a member of a `TagSet`.
public struct Tag: Equatable {

    // MARK: - Tag - Index

    internal typealias Index = Int

    internal  init(index: Index) {
        precondition(index >= 0, "tag index may not be negative")
        self.index = index
    }

    internal var index: Index
}
