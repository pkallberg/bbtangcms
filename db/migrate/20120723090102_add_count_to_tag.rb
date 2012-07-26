class AddCountToTag < ActiveRecord::Migration
  def change
    add_column :tags, :knowledges_count, :integer
    add_column :tags, :questions_count, :integer
    add_column :tags, :profiles_count, :integer
  end
end
# update the count to old record
# not a good idea
#ActsAsTaggableOn::Tag.each do |tag|
#  #Knowledge.tag_counts_on(:tags)
#  tag.knowledges_count = Knowledge.tagged_with(ActsAsTaggableOn::Tag.first.name).count
#  tag.questions_count = Question.tagged_with(ActsAsTaggableOn::Tag.first.name).count
#  tag.profiles_count = Profile.tagged_with(ActsAsTaggableOn::Tag.first.name).count
#  tag.save
#end
# another method may work better
=begin
tags_list = [:tags, :timelines, :categories, :identities]
objects_list = [Knowledge,Question,Profile]
objects_list.each do |object|
  tags_list.each do |t|
    object.tag_counts_on(t).each do |tag|
      tag.knowledges_count = tag.count
      tag.save
    end
  end
end
=end
