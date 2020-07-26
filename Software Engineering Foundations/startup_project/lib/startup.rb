require "employee"

class Startup
    attr_accessor :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding 
        @salaries = salaries
        @employees = []

        # salaries.each do |title, salary|
        #     @salaries[title] = salary
        # end

    end

    def valid_title?(title)
        @salaries.has_key?(title)
        # @salaries.keys.any?(title)
    end

    def > (startup_2)
        @funding > startup_2.funding
    end

    def hire(employee_name, title)
        if self.valid_title?(title)
            new_employee = Employee.new(employee_name, title)
            @employees << new_employee
        else 
            raise "title does not exist"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = @salaries[employee.title]
        raise "not enough money" if funding < salary

        employee.pay(salary)
        @funding -= salary

        # title = employee.title
        # salary = @salaries[title]

        # if funding >= salary
        #     employee.pay(salary)
        #     @funding -= salary
        # else
        #     raise "not enough money"
        # end
    end

    def payday
        @employees.each {|employee| self.pay_employee(employee)}
    end

    def average_salary
        total_cost = 0
        @employees.each {|employee| total_cost += @salaries[employee.title] }
        total_cost / @employees.length * 1.0
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup_2)
        self.funding += startup_2.funding # self.funding works because attr_accessor, if reader, error = undefined method 'funding='
        # startup_2.employees.each {|employee| @employees << employee}
        @employees += startup_2.employees
        startup_2.salaries.each do |title, salary|
            if !valid_title?(title)
                @salaries[title] = salary
            end
        end
        startup_2.close
    end
end
