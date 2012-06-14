class Timeline < CategoryBase
  validates :name, :presence => true, :uniqueness => true
end
