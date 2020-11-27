class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    # The URL pattern it is meant to match (/users, /users/new, /users/(\d+), /users/(\d+)/edit, etc.).
    # The HTTP method (GET, POST, PUT, DELETE).
    # The controller class the route maps to.
    # The action name that should be invoked.
    @pattern, @http_method, @controller_class, @action_name = pattern, http_method, controller_class, action_name
  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    # regex match string req.path 
    # =~ returns index if path match, returns nil otherwise
    # http_method are symbols (in Router class)
    !(pattern =~ req.path).nil? && (http_method == req.request_method.downcase.to_sym)
  end

  # use pattern (a regex) to match req.path (a string) to pull out route params
  # instantiate controller and call controller action
  def run(req, res)
    match_data = pattern.match(req.path)

    params = Hash[match_data.names.zip(match_data.captures)]
    
    @controller_class.new(req, res, params).invoke_action(action_name)
  end
end

# Router keeps track of multiple Routes 
class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
    # example proc: get index_route
    self.instance_eval(&proc)
  end

  # define methods for each http_method => def get(...) def post(...)
  # add these routes to @routes
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  # should return the route that matches this request
  def match(req)
    @routes.find do |route|
      route.matches?(req)
    end
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
    route = match(req)
    if route
      route.run(req, res)
    else
      res.status = 404
    end
  end
end
