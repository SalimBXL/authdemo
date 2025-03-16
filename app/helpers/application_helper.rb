module ApplicationHelper
    def format_enum(enum)
        enum.to_s.humanize
    end

    def shorten(text, length: 100)
        text.length > length ? "#{text[0..length]}..." : text
    end

    def shorten2(text)
        text.length > 2 ? "#{text[0..1]}" : text
    end

    def shorten1(text)
        text.length > 2 ? "#{text[0..0]}" : text
    end

    def get_level_color(level)
        colors = [ "w3-green", "w3-orange", "w3-red" ]
        index = Task.levels[level]
        colors[index]
    end

    def format_level_color(level)
        color = get_level_color(level)
        "<span class='w3-tag w3-round w3-padding w3-green #{color}'>
            #{format_enum level}
        </span>".html_safe
    end
end
