module GoalHelper
    def submit_new_goal(title, privacy = {private: false})
        visit new_goal_url
        fill_in "goal_title", with: title
        if privacy[:private]
            check "goal_private"
        end
        click_button "Create Goal"
    end

    def submit_goal_instance(goal)
        submit_new_goal(goal.title)
    end

    
end