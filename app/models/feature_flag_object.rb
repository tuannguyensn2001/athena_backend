class FeatureFlagObject < ApplicationRecord
  belongs_to :feature_flag
  belongs_to :target_object
end
