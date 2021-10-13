module option.option;

public import option.errors;

/**
 * Option represents a value that may or may not exist.
 *
 * T is the type of the wrapped value.
 */
interface Option(T) {
  import std.traits : isSomeFunction, isPointer;
  private enum isTNullable = is(T == class) || is(T == interface) || isSomeFunction!T || isPointer!T;

  /**
   * Some creates a new Option which holds an existing value.
   * If a null value is given to some, it throws an Error.
   * If you are wrapping a value which you do not know if it exists, use Nullable rather than Some.
	 * Params:
   *   value = The value to encapsulate.
   * Returns: A full Option object.
   * Throws: SomeOfNullError if the given value is null.
   */
  static Option some(in T value) {
    static if (isTNullable) {
      if (value is null) { throw new SomeOfNullError(); }
    }
    return new SomeOption!T(value);
  }

  /**
   * Creates an Option which holds a non-existing value.
   * Calling get on an none Option throws an Error, so check whether an Option holds a value or not.
   * Returns: An empty Option object.
   */
  static Option none() { return new NoneOption!T(); }

  /**
   * If the passed value exists (i.e. is not null), a full Option is returned.
   * Else an empty Option is returned.
   * Params:
   *    value =  The value to encapsulate, which can be 'null'.
   * Returns: An Option object, empty only if the input value is 'null'.
   */
  static Option nullable(in T value) {
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
   * Returns: The value inside the object, if present.
   * Throws: GetOnNoneError When the Option object is empty.
   */
  T get() const;

  /**
   * Returns: true if the object is empty, else false.
   */
  bool isEmpty() const;

  /**
   * \param[in] alternative The alternative to return.
   * Returns: The value inside the object if present, else the passed alternative.
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
  T get() const { throw new GetOnNoneError(); }
  bool isEmpty() const { return true; }
  T or(in T alternative) const { return cast(T)alternative; }
}
