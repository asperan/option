module option.errors;

/**
 * Error thrown when a null value is input to Option.some.
 */
class SomeOfNullError : Error {
  this() {
    super("Option.some does not accept a 'null' value. If you do not know whether the value is 'null' or not, use 'Option.nullable' instead.");
  }
}

/**
 * Error thrown when the method 'get' is called on an empty Option.
 */
class GetOnNoneError : Error {
  this() {
    super("Called method 'get' on empty Option object. Check the object emptyness, or use the method 'or' to provide a default value when the object is empty.");
  }
}
