class Identity < CategoryBase
  validates :name, :presence => true, :uniqueness => true
end
