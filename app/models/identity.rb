class Identity < CategoryBase
  validates :name, :presence => true, :uniqueness => true
  #def timelines
  #  self.children
  #end
end
