class Timeline < CategoryBase
  has_paper_trail   # you can pass various options here
  validates :name, :presence => true
  #def categories
  #  self.children
  #end
end
