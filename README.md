# Option
Option is a library for D. To avoid using `null` around the code, it introduce a `Option` type which wraps a possible-empty value.

The library provides:
- static methods to create `Option` objects:
   - `some` when the `Option` object contains a value;
   - `none` when the `Option` object does not contain a value;
   - `nullable` when it is not known a priori whether the value exists or not;
- class methods to retrieve essential informations about the `Option` object:
   - `get` to unwrap the value (throws an error when the `Option` is empty);
   - `isEmpty` to know whether the `Option` object is empty (value not present) or not;
   - `or` to retrieve the wrapped value if is present, else the passed value (used as the default value). This method never throws.

