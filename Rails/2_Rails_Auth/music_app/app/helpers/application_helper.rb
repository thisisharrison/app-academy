module ApplicationHelper
    
    include ERB::Util
        
    def auth_token
        "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
    end

    def ugly_lyrics(lyrics)
        ugly_lyrics = ''
        lyrics.lines.each do |line|
            ugly_lyrics << "&#9835; #{html_escape(line)}"
        end
        "<pe>#{ugly_lyrics}</pe>".html_safe
    end
end
