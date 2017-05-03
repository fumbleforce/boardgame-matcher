defmodule Bgmatcher.Blog do
  @moduledoc """
  The boundary for the Blog system.
  """

  import Ecto.{Query, Changeset}, warn: false
  import Ecto
  alias Bgmatcher.Repo

  alias Bgmatcher.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(user) do
    Repo.all(assoc(user, :blog_posts))
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(user, id), do: Repo.get!(assoc(user, :blog_posts), id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(post, %{field: value})
      {:ok, %Post{}}

      iex> create_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}, user) do
    user
    |> build_assoc(:blog_posts)
    |> post_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> post_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(user, %Post{} = post) do
      user
      |> build_assoc(:blog_posts)
      |> post_changeset(post)
  end
  
  def new_post(user) do
      user
      |> build_assoc(:blog_posts)
      |> post_changeset(%{})
  end

  defp post_changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
