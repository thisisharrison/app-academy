module AuthHelper
    def login(user)
        visit new_session_url
        fill_in "username", with: user.username
        fill_in "password", with: user.password
        click_button "Log In"
    end

    def bad_login(user)
        visit new_session_url
        fill_in "username", with: user.username
        fill_in "password", with: 'jibberish'
        click_button "Log In"
    end

end