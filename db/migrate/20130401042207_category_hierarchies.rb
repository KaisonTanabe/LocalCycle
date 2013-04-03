# -*- coding: utf-8 -*-
class CategoryHierarchies < ActiveRecord::Migration
  def change
    create_table :category_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... category
      t.integer  :descendant_id, :null => false # ID of the target category
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    # For "all progeny of…" selects:
    add_index :category_hierarchies, [:ancestor_id, :descendant_id], :unique => true

    # For "all ancestors of…" selects
    add_index :category_hierarchies, [:descendant_id]
  end
end
