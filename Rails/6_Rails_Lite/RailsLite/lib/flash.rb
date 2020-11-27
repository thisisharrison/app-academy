require 'json'

class Flash
    attr_reader :now

    def initialize(req)
        cookie = req.cookies['_rails_lite_app_flash']
        if cookie
            # only available in current request
            @now = JSON.parse(cookie)
        else
            @now = {}
        end
        # does not persist data more than 1 request
        @flash = {}
    end

    def [](key)
        @now[key.to_s] || @flash[key.to_s]
    end

    def []=(key, val)
        @flash[key.to_s] = val
    end

    def store_flash(res)
        cookie_attr = {
            path: '/',
            value: @flash.to_json
        }
        res.set_cookie("_rails_lite_app_flash", cookie_attr)
    end
end
