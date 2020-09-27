class Employee
    attr_reader :name, :title, :salary
    attr_accessor :boss

    def initialize(name, title, salary, boss = nil)
        @name, @title, @salary, @boss = name, title, salary, boss
    end

    def boss=(boss)
        @boss = boss
        boss.add_employee(self) unless boss.nil?
        boss
    end

    def bonus(multiplier)
        @salary * multiplier
    end
end

class Manager < Employee
    attr_reader :employees

    def initialize(name, title, salary, boss = nil)
        super(name, title, salary, boss)
        @employees = [] 
    end

    def bonus(multiplier)
        self.total_subsalary * multiplier
    end

    def add_employee(sub)
        @employees << sub
        sub
    end

    protected 

    def total_subsalary
        total = 0
        @employees.each do |staff|
            if staff.is_a?(Manager)
                total += staff.salary + staff.total_subsalary
            else
                total += staff.salary
            end
        end
        total
    end

end

if __FILE__ == $PROGRAM_NAME
    ned = Manager.new('Ned', 'Founder', 1000000)
    darren = Manager.new('Darren', 'TA Manager', 78000, ned)
    shawna = Employee.new('Shawna', 'TA', 12000, darren)
    david = Employee.new('David', 'TA', 10000, darren)
    ned.add_employee(darren)
    darren.add_employee(shawna)
    darren.add_employee(david)
    p darren
    p shawna
    p david
    p ned.bonus(5) # => 500_000
    p darren.bonus(4) # => 88_000
    p david.bonus(3) # => 30_000
end