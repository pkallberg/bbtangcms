class Category < CategoryBase
  has_paper_trail   # you can pass various options here
  validates :name, :presence => true
end
