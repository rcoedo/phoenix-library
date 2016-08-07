# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixLibrary.Repo.insert!(%PhoenixLibrary.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PhoenixLibrary.Repo
alias PhoenixLibrary.Book

books = [
  %Book{title: "Elixir in action", isbn: "9781617292019", author: ["Saša Jurić"]},
  %Book{title: "Programming Elixir", isbn: "9781937785581", author: ["Dave Thomas"]},
  %Book{title: "Programming Phoenix", isbn: "9781680501452", author: ["Chris McCord", "Bruce Tate", "José Valim"]}
]

Enum.each(books, fn (book) -> Repo.insert!(book) end)
