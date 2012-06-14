# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

BBTangCMS::Config.tag.keys.each do |fkey|
  #debugger
  fcategory=CategoryBase.find_or_create_by_name(fkey.to_s)
  fcategory.type= "Identity"
  fcategory.save
  BBTangCMS::Config.tag[fkey].keys.each do |skey|
    scategory=fcategory.children.find_or_create_by_name(skey.to_s)
    scategory.type = "Timeline"
    scategory.save
    tstring = BBTangCMS::Config.tag[fkey][skey]

    tstring.split(' ').each do |svalue|
      tcategory=scategory.children.find_or_create_by_name(svalue)
      tcategory.type = "Category"
      tcategory.save        
    end
  end
end
