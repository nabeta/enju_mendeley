module EnjuMendeley
  module Manifestation
    extend ActiveSupport::Concern

    included do
      has_one :mendeley_record
    end
  end
end
