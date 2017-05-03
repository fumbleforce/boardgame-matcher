defmodule Bgmatcher.Web.PostController do
  use Bgmatcher.Web, :controller

  alias Bgmatcher.Blog
  alias Bgmatcher.Blog.Post
  
  plug :assign_user

  def index(conn, _params) do
    posts = Blog.list_posts(conn.assigns[:user])
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Blog.new_post(conn.assigns[:user])
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params, conn.assigns[:user]) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: user_post_path(conn, :show, conn.assigns[:user], post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(conn.assigns[:user], id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(conn.assigns[:user], post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: user_post_path(conn, :show, conn.assigns[:user], post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: user_post_path(conn, :index, conn.assigns[:user]) )
  end
  
  defp assign_user(conn, _opts) do
    case conn.params do
      %{"user_id" => user_id} ->
        case Bgmatcher.Accounts.get_user(user_id) do
          nil  -> invalid_user(conn)
          user -> assign(conn, :user, user)
        end
      _ -> invalid_user(conn)
    end
  end

  defp invalid_user(conn) do
    conn
    |> put_flash(:error, "Invalid user!")
    |> redirect(to: page_path(conn, :index))
    |> halt
  end
end
