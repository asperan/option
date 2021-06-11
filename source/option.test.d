module option_test;
import option;

class A {
  int c;
  this() {c = 5;}
}

unittest {
  Option!int i = Option!int.Some(3);
  assert(!i.isEmpty);
  assert(i.get == 3);
}

unittest {
  Option!int i = Option!int.None();
  assert(i.isEmpty);
}

unittest {
  import std.exception : assertThrown;
  assertThrown!Error(Option!A.Some(null));
}

unittest {
  Option!A i = Option!A.Nullable(null);
  assert(i.isEmpty);
  Option!A j = Option!A.Nullable(new A());
  assert(!j.isEmpty);
}

unittest {
  Option!bool i = Option!bool.Nullable(false);
  assert(!i.isEmpty);
}

unittest {
  Option!int i = Option!int.Some(5);
  assert(i.or(0) == 5);
  Option!int j = Option!int.None();
  assert(j.or(0) == 0);
}
