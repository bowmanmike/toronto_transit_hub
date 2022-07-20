import_if_available(Ecto.Query, warn: false)
import_if_available(Ecto.Changeset)

alias TorontoTransitHub.Repo
alias TorontoTransitHub.Clients.{GoClient, TTCClient, UPExpressClient}
