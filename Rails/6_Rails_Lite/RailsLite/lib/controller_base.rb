require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  def self.protect_from_forgery
    # class variable - shared between class and subclass so when Controllers inherit ControllerBase, they have this var
    @@protect_from_forgery = true
  end

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params.merge(req.params)
    @already_built_response = false
    if @req.request_method == 'GET'
      @@protect_from_forgery = false
    else
      @@protect_from_forgery = true
    end
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'double render error' if already_built_response?
    @res.status = 302
    @res['Location'] = url
    @already_built_response = true
    session.store_session(@res)
    @res.finish
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'double render error' if already_built_response?
    @res['Content-Type'] = content_type
    @res.write(content)
    @already_built_response = true
    session.store_session(@res)
    @res.finish
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    dir_path = File.dirname(__FILE__)
    file = File.join(
      dir_path, '..',
      "views", self.class.name.underscore, 
      "#{template_name}.html.erb"
    )
    
    # views/#{controller_name}/#{template_name}.html.erb
    # read current directory
    # move up to RailsLite directory
    # views folder 
    # Controller file + template name
    # puts self.class.name # CatsController
    # puts self.class.name.underscore # cats_controller => undercase and underscored
    
    code = File.read(file)
    content = ERB.new(code).result(binding)
    render_content(content, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    # form_authenticity_token unless ControllerBase.protect_from_forgery
    if protect_from_forgery?
      # non-get request, check token
      check_authenticity_token
    else
      # possible writing a form 
      form_authenticity_token
    end
    
    self.send(name)
    render(name) unless already_built_response?
    nil
  end

  def form_authenticity_token
    @token ||= SecureRandom.urlsafe_base64(16)
    res.set_cookie('authenticity_token', value: @token, path: '/')
    @token
  end

  def check_authenticity_token
    cookie = req.cookies['authenticity_token']
    # params have merged req.params
    unless cookie && cookie == params['authenticity_token']
      raise 'Invalid authenticity token'
    end
  end

  def protect_from_forgery?
    @@protect_from_forgery
  end
  
end

