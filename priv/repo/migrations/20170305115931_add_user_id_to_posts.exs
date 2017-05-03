defmodule Bgmatcher.Repo.Migrations.AddUserIdToPosts do
  use Ecto.Migration

  def change do
    alter table(:blog_posts) do
      add :user_id, references(:accounts_users)
    end
    
    create index(:blog_posts, [:user_id])
  end
end
