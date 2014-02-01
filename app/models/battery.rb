class Battery < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :user, :level
    validates_inclusion_of :level, :in => 1..4

    before_validation :set_levels

    private
        def set_levels
            if self.level > 4
                self.level = 4
            elsif self.level < 1
                self.level = 1
            end
        end
end
