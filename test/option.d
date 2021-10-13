module option_test;
import option;

private class A {
  int c;
  this() {c = 5;}
}

unittest {
  Option!int i = Option!int.some(3);
  assert(!i.isEmpty);
  assert(i.get == 3);
}

unittest {
  Option!int i = Option!int.none();
  assert(i.isEmpty);
}

unittest {
  import std.exception : assertThrown;
  assertThrown!Error(Option!A.some(null));
}

unittest {
  Option!A i = Option!A.nullable(null);
  assert(i.isEmpty);
  Option!A j = Option!A.nullable(new A());
  assert(!j.isEmpty);
}

unittest {
  Option!bool i = Option!bool.nullable(false);
  assert(!i.isEmpty);
}

unittest {
  Option!int i = Option!int.some(5);
  assert(i.or(0) == 5);
  Option!int j = Option!int.none();
  assert(j.or(0) == 0);
}
