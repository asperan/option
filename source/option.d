module option;

/**
 * Option represents a value that may or may not exist.
 */
interface Option(T) {
  import std.traits : isSomeFunction, isPointer;
  private enum isTNullable = is(T == class) || is(T == interface) || isSomeFunction!T || isPointer!T;
  
  /**
   * Some creates a new Option which holds an existing value.
   * If a null value is given to Some, it throws an Error.
   * If you are wrapping a value which you do not know if it exists, use Nullable rather than Some.
   */
  static Option Some(in T value) {
    static if (isTNullable) {
      if (value is null) { throw new Error("Option.Some does not accept a 'null' value"); }
    }
    return new SomeOption!T(value);
  }

  /**
   * Creates an Option which holds a non-existing value.
   * Calling get on an None Option throws an Error, so check whether an Option holds a value or not.
   */
  static Option None() { return new NoneOption!T(); }

  /**
   * If the passed value exists (i.e. is not null), a full Option is returned.
   * Else an empty Option is returned.
   */
  static Option Nullable(in T value) {
    static if (isTNullable) {
      if (value is null) {
      	return new NoneOption!T();
	    } else {
  	    return new SomeOption!T(value);
    	}
    } else {
			return new SomeOption!T(value);
    }
  }

  /**
   * Returns the stored value.
   * An empty Option throws an Error when 'get' is called onto it.
   */
  T get() const;

  /**
   * Returns whether there is a stored value.
   */
  bool isEmpty() const;

  /**
   * Returns the stored value if present, else the given alternative.
   */
  T or(in T alternative) const;
}

private class SomeOption(T) : Option!T {
  private const T value;

  this(in T t) { value = t; }
  T get() const { return cast(T)value; }
  bool isEmpty() const { return false; }
  T or(in T alternative) const { return cast(T)value; }
}

private class NoneOption(T) : Option!T {
  T get() const { throw new Error("Called 'get' on empty Option object."); }
  bool isEmpty() const { return true; }
  T or(in T alternative) const { return cast(T)alternative; }
}
