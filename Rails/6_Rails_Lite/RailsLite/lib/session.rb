require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    cookie = req.cookies['_rails_lite_app']
    if cookie
      @data = JSON.parse(cookie)
    else
      @data = {}
    end
  end

  def [](key)
    @data[key]
  end

  def []=(key, val)
    @data[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    cookie_attr = {
      # set to root url
      path: '/',
      # save data in json
      value: @data.to_json
    }
    # set_cookie(name, cookie attributes)
    res.set_cookie("_rails_lite_app", cookie_attr)
  end
end
