class Activity < PublicActivity::Activity
  acts_as_readable :on => :created_at
end