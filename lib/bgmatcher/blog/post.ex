defmodule Bgmatcher.Blog.Post do
  use Ecto.Schema
  
  schema "blog_posts" do
    field :title, :string
    field :body, :string

    timestamps()
    
    belongs_to :accounts_user, Bgmatcher.Accounts.User
  end
end
