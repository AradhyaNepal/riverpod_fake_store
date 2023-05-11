class Person{
  String name;
  static final Person _instance=Person._("Hello");
  Person._(this.name);

  factory Person()=>_instance;
}

//factory keyword vs factory pattern-> Singeleton pattern