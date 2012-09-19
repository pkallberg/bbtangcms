# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
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
=end
##################default cms_roles
=begin
BBTangCMS::Config.cms_roles[:roles].each do |r|
  if r.present?
    CmsRole.find_or_create_by_name(r)
  end
end
=end
=begin
admin = CmsRole.find_by_name("admin")
editoradmin = CmsRole.find_by_name("editoradmin")
editor = CmsRole.find_by_name("editor")
operatoradmin = CmsRole.find_by_name("operatoradmin")
operator = CmsRole.find_by_name("operator")
UserRoles :Admin
user1 = User.find_by_email("864248765@qq.com")
user1.cms_roles << admin
user2 = User.find_by_email("wangy5278@163.com")
user2.cms_roles << admin
=end
#################setting permits the first you should makesure you do it in cancan Ability
if BBTangCMS::Config.permits.has_key? :permit
  BBTangCMS::Config.permits[:permit].each do |kv|
    Permit.find_or_create_by_name(kv[0]) if kv.present?
  end
end
recomment_expert_categories = %w(妇产 儿科 营养喂哺 亲子早教 才艺兴趣 美容纤体 职业规划 心理咨询 生活居家)
if recomment_expert_categories.present?
  recomment_expert_categories.each do |expert_category|
    Recommend::ExpertCategory.create(name: expert_category) unless Recommend::ExpertCategory.where(:name => expert_category).entries.present?
  end
end
