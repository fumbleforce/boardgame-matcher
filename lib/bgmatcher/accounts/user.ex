defmodule Bgmatcher.Accounts.User do
  use Ecto.Schema
  
  schema "accounts_users" do
    field :username, :string
    field :email, :string
    field :password_digest, :string

    timestamps()
    
    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    
    has_many :blog_posts, Bgmatcher.Blog.Post  
  end
end
