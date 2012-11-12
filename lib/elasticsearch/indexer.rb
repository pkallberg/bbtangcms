# encoding: utf-8
module ElasticSearchable
  module Question
    def self.included(base)
      base.class_eval <<-"end_eval"
        tire do
          mapping do
            indexes :id,              type: 'integer', :index => 'not_analyzed', :include_in_all => false
            #indexes :title,           type: 'string'
            indexes :content,         type: 'string'
            indexes :created_at,      type: 'date'
            indexes :tag_list,        as:   'tag_list.join(" ")'
            indexes :timeline_list,   as:   'timeline_list.join(" ")'
            indexes :category_list,        as:   'category_list.join(" ")'
            indexes :identity_list,   as:   'identity_list.join(" ")'


            indexes :tags, :type => 'string', :index => :not_analyzed, as:   'tag_list'
            indexes :timelines, :type => 'string', :index => :not_analyzed,   as:   'timeline_list'
            indexes :categories, :type => 'string', :index => :not_analyzed,        as:   'category_list'
            indexes :identities, :type => 'string', :index => :not_analyzed,   as:   'identity_list'


            #indexes :tags do
            #  indexes :name
            #end
            indexes :valid,           type: 'boolean', as: 'deleted_at.nil?'
          end
        end
      end_eval
    end
  end

  module Knowledge
    def self.included(base)
      base.class_eval <<-"end_eval"
        tire do
          mapping do
            indexes :id,              type: 'integer', :index => 'not_analyzed', :include_in_all => false
            indexes :title,           type: 'string'
            indexes :summary,         type: 'string'
            indexes :content,         type: 'string'
            indexes :created_at,      type: 'date'
            indexes :tag_list,        as:   'tag_list.join(" ")'
            indexes :timeline_list,   as:   'timeline_list.join(" ")'
            indexes :category_list,        as:   'category_list.join(" ")'
            indexes :identity_list,   as:   'identity_list.join(" ")'


            indexes :tags, :type => 'string', :index => :not_analyzed, as:   'tag_list'
            indexes :timelines, :type => 'string', :index => :not_analyzed,   as:   'timeline_list'
            indexes :categories, :type => 'string', :index => :not_analyzed,        as:   'category_list'
            indexes :identities, :type => 'string', :index => :not_analyzed,   as:   'identity_list'

            indexes :valid,           type: 'boolean', as: 'deleted_at.nil?'
          end
        end
      end_eval
    end
  end

  module Note
    def self.included(base)
      base.class_eval <<-"end_eval"
        tire do
          mapping do
            indexes :id,              type: 'integer'
            indexes :title,           type: 'string'
            indexes :content,         type: 'string'
            indexes :created_at,      type: 'date'
          end
        end
      end_eval
    end
  end

  module User
    def self.included(base)
      base.class_eval <<-"end_eval"
        tire do
          mapping do
            indexes :id,                    type: 'integer'
            indexes :email,                 type: 'string'
            indexes :nickname,              as:   'profile.nickname'
            indexes :label,                 as:   'profile.label'
            indexes :resume,                as:   'profile.resume'
            indexes :profession,            as:   'profile.profession'
            indexes :expert_field,          as:   'profile.expert_field'
            indexes :city,                  as:   'profile.city'
            indexes :tag_list,              as:   'profile.tag_list.join(" ")'
            indexes :expert_category_list,  as:   'profile.expert_category_list.join(" ")'
            indexes :valid,                 type: 'boolean', as: 'profile.present?'
          end
        end
      end_eval
    end
  end

  module Group
    def self.included(base)
      base.class_eval <<-"end_eval"
        tire do
          mapping do
            indexes :id,                    type: 'integer'
            indexes :name,                  type: 'string'
            indexes :valid,                 type: 'boolean', as: 'deleted_at.nil?'
          end
        end
      end_eval
    end
  end

  module Goods
    def self.included(base)
      base.class_eval <<-"end_eval"
        tire do
          mapping do
            indexes :goods_id,              type: 'integer'
            indexes :goods_name,            type: 'string'
            indexes :goods_brief,           type: 'string'
            indexes :goods_desc,            type: 'string'
            indexes :valid,                 type: 'boolean', as: 'is_on_sale'
          end
        end
      end_eval
    end
  end
end
