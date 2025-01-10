class Registry < ApplicationRecord
    enum :status, { active: 0, inactive: 1, scheduled: 2 }
    validates :source, :destination, :status, presence: true
    validates :status, inclusion: { in: statuses.keys }

    def as_json(options = {})
        if confidential
          super(only: [:id, :source, :confidential, :created_at])
        else
          super
        end
    end
end
