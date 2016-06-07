defmodule Constable.UserEditsCommentTest do
  use Constable.AcceptanceCase

  test "user edits ", %{session: session} do
    announcement = insert(:announcement)
    user = insert(:user)

    session
    |> visit(announcement_path(Endpoint, :show, announcement, as: user.id))
    |> fill_in("comment_body", with: "My Cool Comment")
    |> submit_comment

    assert has_comment_text?(session, "My Cool Comment")

    session
    |> click_edit_comment
    |> fill_in("comment_body", with: "My Updated Comment")
    |> submit_comment

    assert has_comment_text?(session, "My Cool Comment")
  end

  defp submit_comment(session) do
    session
    |> find("#submit-comment")
    |> click
  end

  defp has_comment_text?(session, comment_text) do
    find(session, ".comments-list") |> has_text?(comment_text)
  end

  defp click_edit_comment(session) do
    session
    |> find("a[data-role=edit-comment]")
    |> click

    session
  end
end
