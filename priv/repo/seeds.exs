# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LofiPlay.Repo.insert!(%LofiPlay.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

%LofiPlay.Content.Component{
  name: "Alert",
  tags: "#alert",
  type: 2,
  body: """
<div class="alert alert-{{variation}}">{{ content }}</div>
""",
  ingredients: """
@content: #text
- Message
@variation: #choice
- info
- success
- danger
"""
}
|> LofiPlay.Repo.insert!
