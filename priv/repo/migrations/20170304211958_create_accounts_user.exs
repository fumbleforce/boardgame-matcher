defmodule Bgmatcher.Repo.Migrations.CreateBgmatcher.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :username, :string
      add :email, :string
      add :password_digest, :string

      timestamps()
    end

  end
end
