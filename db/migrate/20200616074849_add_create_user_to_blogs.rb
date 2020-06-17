class AddCreateUserToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :create_user, :string
  end
end
