import 'dart:io';

// Define  abstract class Animal
abstract class Animal {
  String makeSound();
}

// Implement subclass Dog
class Dog extends Animal {
  @override
  String makeSound() {
    return 'Woof';
  }
}

// Implement subclass Cat
class Cat extends Animal {
  @override
  String makeSound() {
    return 'Meow';
  }
}

// Define Serializable interface
abstract class Serializable {
  void readFromFile(String filePath);
  void writeToFile(String filePath);
}

// Implement AnimalSerializer class
class AnimalSerializer implements Serializable {
  Animal animal;

  AnimalSerializer(this.animal); // Initializing animal in the constructor

  @override
  void readFromFile(String filePath) {
    List<String> lines = File(filePath).readAsLinesSync();
    if (lines.isNotEmpty) {
      String type = lines[0];
      if (type == 'Dog') {
        animal = Dog();
      } else if (type == 'Cat') {
        animal = Cat();
      }
    }
  }

  @override
  void writeToFile(String filePath) {
    File(filePath).writeAsStringSync(toString());
  }

  @override
  String toString() {
    return animal.makeSound();
  }
}

void main() {
  List<Animal> animals = [];

  // Read animals from file
  AnimalSerializer serializer =
      AnimalSerializer(Cat()); // Pass a default Object
  serializer.readFromFile('animals.txt');
  animals.add(serializer.animal);

  // Demonstrate serialization and deserialization
  for (Animal animal in animals) {
    print('Sound: ${animal.makeSound()}');
  }

  // Write animals to file
  serializer.writeToFile('animals_out.txt');
}
