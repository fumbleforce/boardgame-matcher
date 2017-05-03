defmodule Bgmatcher.AccountsTest do
  use Bgmatcher.DataCase

  alias Bgmatcher.Accounts
  alias Bgmatcher.Accounts.User
  
  @valid_attrs %{
    email: "some email",
    password: "some password",
    password_digest: "ABC123",
  }
  @create_attrs %{
    email: "some email",
    password: "some password",
    password_confirmation: "some password",
    username: "some username"
  }
  @update_attrs %{
    email: "some updated email",
    password: "some updated password",
    password_confirmation: "some updated password",
    username: "some updated username"
  }
  @invalid_attrs %{
    email: nil,
  }

  def fixture(:user, attrs \\ @create_attrs) do
    {:ok, user} = Accounts.create_user(attrs)
    user
  end

  test "list_users/1 returns all users" do
    user = fixture(:user)
    assert Accounts.list_users() == [user]
  end

  test "get_user! returns the user with given id" do
    user = fixture(:user)
    assert Accounts.get_user!(user.id) == user
  end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Accounts.create_user(@create_attrs)
    
    assert user.email == "some email"
    assert user.password == nil
    assert user.password_confirmation == nil
    assert user.username == "some username"
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = fixture(:user)
    assert {:ok, user} = Accounts.update_user(user, @update_attrs)
    assert %User{} = user
    
    assert user.email == "some updated email"
    assert user.password == nil
    assert user.password_confirmation == nil
    assert user.username == "some updated username"
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = fixture(:user)
    assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    assert user == Accounts.get_user!(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = fixture(:user)
    assert {:ok, %User{}} = Accounts.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = fixture(:user)
    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end
  
  test "password_digest value gets set to a hash" do
    changeset = Accounts.user_changeset(%User{}, @create_attrs)
    assert Comeonin.Bcrypt.checkpw(
      @valid_attrs.password,
      Ecto.Changeset.get_change(changeset, :password_digest))
  end
  
  test "password_digest value does not get set if password is nil" do
    changeset = Accounts.user_changeset(%User{}, %{
      email: "test@test.com",
      password: nil,
      password_confirmation: nil,
      username: "test"})
    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end
end
