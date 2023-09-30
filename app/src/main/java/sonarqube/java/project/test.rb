class Student
    attr_accessor :name, :age
  end
  
  def test
    s = Student.new
    s.name = "John"
    s.age = 20
    return s
  end
  
  x = 10
  y = "hello"
  s = test
  print("Student Details for entity: " + s.to_s)
  print("\n")
  print("Student Name: " + s.name)
  print("\n")
  print("Student Age: " + s.age.to_s)