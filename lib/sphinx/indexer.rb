# encoding: utf-8
module SphinxIndexable
  module Question
    def self.included(base)
      base.class_eval <<-"end_eval"  
        define_index do
          indexes title
          indexes content
          #indexes identity_taggings.tag(:name), as: :identity_tags
          #indexes timeline_taggings.tag(:name), as: :timeline_tags
          #indexes category_taggings.tag(:name), :as => :category_tags
          indexes tag_taggings.tag(:name), :as => :tag_tags
          #has identity_taggings.tag(:id), as: :identity_tags
          #has timeline_taggings.tag(:id), as: :timeline_tags
          where "deleted_at is null"
          #声明使用实时索引
          set_property :delta => true
        end
      end_eval
    end
  end

  module Knowledge
    def self.included(base)
      base.class_eval <<-"end_eval"  
        define_index do
          indexes title
          indexes summary
          indexes content
          #indexes identity_taggings.tag(:name), as: :identity_tags
          #indexes timeline_taggings.tag(:name), as: :timeline_tags
          #indexes category_taggings.tag(:name), :as => :category_tags
          indexes tag_taggings.tag(:name), :as => :tag_tags
          #has identity_taggings.tag(:id), as: :identity_tags
          #has timeline_taggings.tag(:id), as: :timeline_tags
          where "deleted_at is null"
          #声明使用实时索引
          set_property :delta => true
        end
      end_eval
    end
  end

  module Profile
    def self.included(base)
      base.class_eval <<-"end_eval"  
        define_index do
          indexes nickname
          indexes label
          indexes real_name
          indexes user.email
          #声明使用实时索引
          set_property :delta => true
        end
      end_eval
    end
  end

  module Group
    def self.included(base)
      base.class_eval <<-"end_eval"  
        define_index do
          indexes name
          where "deleted_at is null"
          #声明使用实时索引
          set_property :delta => true
        end
      end_eval
    end
  end
  
  module Goods
    def self.included(base)
      base.class_eval <<-"end_eval"  
        define_index do
          indexes goods_name
          indexes goods_brief
          indexes goods_desc
          where "is_on_sale is true"
          #声明使用实时索引
          #set_property :delta => true
        end
      end_eval
    end
  end
end
