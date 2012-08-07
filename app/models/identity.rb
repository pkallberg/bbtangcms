class Identity < CategoryBase
  has_paper_trail   # you can pass various options here
  validates :name, :presence => true, :uniqueness => true
  #def timelines
  #  self.children
  #end
end
