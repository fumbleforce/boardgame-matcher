defmodule Bgmatcher.Web.PageController do
  use Bgmatcher.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
