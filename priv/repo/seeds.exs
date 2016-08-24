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
import Ecto.Query, only: [from: 1]

alias PhoenixLibrary.Repo
alias PhoenixLibrary.Book

books = [
  %Book{
    title: "Elixir in action",
    isbn: "9781617292019",
    author: ["Saša Jurić"],
    publisher: "Manning",
    thumbnail: "https://books.google.es/books/content?id=qkfUrQEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE73eD-jPuUmzhRGAqa6IsunKEWtqUk9HDodb7JnT14tTcRFcgsK9SrwWjzpSONc64f1I2Zp0BP3K9h5yITa6u1ccu2jpTg7MAusCQ0YiLNMAcmtnrEfhr4ch4A_K71RwzjGb8Fm3&source=gbs_api"
  },
  %Book{
    title: "Programming Elixir",
    isbn: "9781937785581",
    author: ["Dave Thomas"],
    publisher: "Pragmatic Bookshelf",
    thumbnail: "https://books.google.es/books/content?id=yLBAjgEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE73OFxV1rz4Y-3pzBu5NP7q8B5WVveLW0VPkp84S2GuJbAcJkpywCQzfyzRjm4u9jYQr2eXi8cjwgUa5sgyVNTd74plLg1X-nMN1JzyZkhA_jH04VglRFdCQa8B2Z4akSMv_ReOO&source=gbs_api"
  },
  %Book{
    title: "Programming Phoenix",
    isbn: "9781680501452",
    author: ["Chris McCord", "Bruce Tate", "José Valim"],
    publisher: "Pragmatic Bookshelf",
    thumbnail: "https://books.google.es/books/content?id=yLBAjgEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE73OFxV1rz4Y-3pzBu5NP7q8B5WVveLW0VPkp84S2GuJbAcJkpywCQzfyzRjm4u9jYQr2eXi8cjwgUa5sgyVNTd74plLg1X-nMN1JzyZkhA_jH04VglRFdCQa8B2Z4akSMv_ReOO&source=gbs_api"
  }
]

Repo.delete_all(from book in "books")
Enum.each(books, fn (book) -> Repo.insert!(book) end)
