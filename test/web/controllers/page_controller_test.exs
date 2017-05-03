defmodule Bgmatcher.Web.PageControllerTest do
  use Bgmatcher.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Boardgame Matcher!"
  end
end
