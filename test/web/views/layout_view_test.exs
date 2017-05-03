defmodule Bgmatcher.Web.LayoutViewTest do
  use Bgmatcher.Web.ConnCase, async: true
  
  alias Bgmatcher.Repo
  alias Bgmatcher.Web.LayoutView
  alias Bgmatcher.Accounts
  alias Bgmatcher.Accounts.User
  
  setup do
    Accounts.user_changeset(%User{}, %{
      username: "test",
      password: "test",
      password_confirmation: "test",
      email: "test@test.com"})
    |> Repo.insert
    {:ok, conn: build_conn()}
  end
  
  test "current user returns the user in the session", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{username: "test", password: "test"}
    assert LayoutView.current_user(conn)
  end
  
  test "current user returns nothing if there is no user in the session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end