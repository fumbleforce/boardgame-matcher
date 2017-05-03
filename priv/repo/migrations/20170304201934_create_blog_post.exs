defmodule Bgmatcher.Repo.Migrations.CreateBgmatcher.Blog.Post do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string
      add :body, :text

      timestamps()
    end

  end
end
