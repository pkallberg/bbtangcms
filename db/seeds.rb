# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#BBTangCMS::Config.tag.keys.each do |fkey|
#  #debugger
#  fcategory=CategoryBase.find_or_create_by_name(fkey.to_s)
#  fcategory.type= "Identity"
#  fcategory.save
#  BBTangCMS::Config.tag[fkey].keys.each do |skey|
#    scategory=fcategory.children.find_or_create_by_name(skey.to_s)
#    scategory.type = "Timeline"
#    scategory.save
#    tstring = BBTangCMS::Config.tag[fkey][skey]

#    tstring.split(' ').each do |svalue|
#      tcategory=scategory.children.find_or_create_by_name(svalue)
#      tcategory.type = "Category"
#      tcategory.save
#    end
#  end
#end
##################default cms_roles
#BBTangCMS::Config.cms_roles[:roles].each do |r|
#  if r.present?
#    CmsRole.create!(:name => r)
#  end
#end
#admin = CmsRole.find_by_name(:name => "admin")
#editoradmin = CmsRole.find_by_name(:name => "editoradmin")
#editor = CmsRole.find_by_name(:name => "editor")
#operatoradmin = CmsRole.find_by_name(:name => "operatoradmin")
#operator = CmsRole.find_by_name(:name => "operator")
# UserRoles :Admin
#user1 = User.find_by_email("864248765@qq.com")
#user1.roles << admin
#user2.roles << editoradmin
#################setting permits the first you should makesure you do it in cancan Ability
if BBTangCMS::Config.permits.has_key? :permit
  BBTangCMS::Config.permits[:permit].each do |kv|
    Permit.find_or_create_by_name(kv[0]) if kv.present?
  end
end
