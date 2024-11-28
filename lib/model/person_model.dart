class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  // Factory method to create a Person from a JSON map
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] ?? '',  // Use the correct key from the API response
      age: json['age'] ?? 0,     // Use the correct key from the API response
    );
  }
}
