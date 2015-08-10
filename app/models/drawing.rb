class Drawing < ActiveRecord::Base
  serialize :numbers, JSON
end
