defmodule Constable.CommentController do
  use Constable.Web, :controller

  alias Constable.{Announcement, Comment}
  alias Constable.Services.CommentCreator

  plug :scrub_params, "comment" when action == :create

  def create(conn, %{"announcement_id" => announcement_id, "comment" => comment_params}) do
    comment_params = comment_params
      |> Map.put("user_id", conn.assigns.current_user.id)
      |> Map.put("announcement_id", announcement_id)

    case CommentCreator.create(comment_params) do
      {:ok, _comment} ->
        redirect(conn, to: announcement_path(conn, :show, announcement_id))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, gettext("Comment was invalid"))
        |> redirect(to: announcement_path(conn, :show, announcement_id))
    end
  end

  def edit(conn, %{"announcement_id" => announcement_id, "id" => comment_id}) do
    announcement = Repo.get!(Announcement, announcement_id)
    comment = Repo.get!(Comment, comment_id)
    Constable.AnnouncementController.show(conn, %{"id" => announcement_id})
    # render Constable.AnnouncementView, "show.html", conn: conn, announcement: announcement
  end
end
