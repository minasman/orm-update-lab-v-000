require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade 
  attr_reader :id
  
  def initialize(id = nil, name, grade)
    @id = nil
    @name = name
    @grade = grade 
  end
  
  def self.create_table 
    sql = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)"
    DB[:conn].execute(sql)
  end
  
  def self.drop_table 
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end
    
  def save 
    if self.id 
      self.update
    else
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES (?, ?)    
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
