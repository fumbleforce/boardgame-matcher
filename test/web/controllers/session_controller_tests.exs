defmodule Bgmatcher.SessionControllerTest do
  use Bgmatcher.ConnCase
  
  alias Bgmatcher.Accounts
  alias Bgmatcher.Accounts.User
  
  @existing_user = %{
    username: "test",
    password: "test"
  }
  @create_user = %{
    username: "test",
    email: "test@test.com"
    password: "test",
    password_confirmation: "test"
  }
  
  setup do
    Accounts.user_changeset(%User{}, @create_user)
    |> Repo.insert
    {:ok, conn: build_conn()}
  end
  
  test "shows the login form", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "Login"
  end
  
  test "creates a new user session for a valid user", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: @existing_user
    assert get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Sign in successful!"
    assert redirected_to(conn) == page_path(conn, :index)
  end
  
  test "does not create a session with a bad login", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{
      username: "test", password: "wrong"}
    refute get_session(conn, :current_user)
    assert get_flash(conn, :error) == "Invalid username/password combination!"
    assert redirected_to(conn) == page_path(conn, :index)
  end
  
  test "does not create a session if user does not exist", %{conn: conn} do    
    conn = post conn, session_path(conn, :create), user: %{
      username: "foo", password: "wrong"}
    assert get_flash(conn, :error) == "Invalid username/password combination!"
    assert redirected_to(conn) == page_path(conn, :index)
  end
  
  test "deletes the user session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})
    conn = delete conn, session_path(conn, :delete, user)
    refute get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Signed out successfully!"
    assert redirected_to(conn) == page_path(conn, :index)
  end
end