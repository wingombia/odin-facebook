module ApplicationHelper
    def print_time_diff(time)
        distance_of_time_in_words(Time.now.to_i - time.to_i) + " ago"
    end

end
