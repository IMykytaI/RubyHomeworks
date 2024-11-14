require 'date'

class Student
  attr_accessor :surname, :name, :date_of_birth
  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    self.date_of_birth = date_of_birth
    validate_date_of_birth
    Student.add_student(self) # Виклик класового методу через ім'я класу
  end

  def self.students
    @@students
  end

  def date_of_birth=(dob)
    raise ArgumentError, "Date of birth must be in the past" if dob > Date.today
    @date_of_birth = dob
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if (today.month < @date_of_birth.month) || (today.month == @date_of_birth.month && today.day < @date_of_birth.day)
    age
  end

  def self.add_student(student)
    unless @@students.any? { |s| s.surname == student.surname && s.name == student.name && s.date_of_birth == student.date_of_birth }
      @@students << student
    end
  end

  def self.remove_student(student)
    @@students.delete_if { |s| s.surname == student.surname && s.name == student.name && s.date_of_birth == student.date_of_birth }
  end

  def self.get_students_by_age(age)
    @@students.select { |s| s.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |s| s.name == name }
  end

  private

  def validate_date_of_birth
    raise ArgumentError, "Date of birth must be in the past" if @date_of_birth > Date.today
  end
end




