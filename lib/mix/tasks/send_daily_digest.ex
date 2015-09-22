defmodule Mix.Tasks.Constable.SendDailyDigest do
  use Mix.Task
  require Logger

  import Ecto.Query

  alias Constable.Repo
  alias Constable.User

  def run(_) do
    Logger.info("Starting application")
    Mix.Task.run "app.start"
    Logger.info("Started application")

    users = Repo.all(from u in User, where: u.daily_digest == true)
    Logger.info("Sending email to #{length(users)} user(s)")

    Pact.get(:daily_digest).send_email(users)
    Logger.info("Email sent via #{Pact.get(:daily_digest)}")
  end
end
