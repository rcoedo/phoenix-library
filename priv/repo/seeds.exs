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
    thumbnail: "https://books.google.es/books/content?id=qkfUrQEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE73eD-jPuUmzhRGAqa6IsunKEWtqUk9HDodb7JnT14tTcRFcgsK9SrwWjzpSONc64f1I2Zp0BP3K9h5yITa6u1ccu2jpTg7MAusCQ0YiLNMAcmtnrEfhr4ch4A_K71RwzjGb8Fm3&source=gbs_api",
    description: """
    Don't accept the compromise between fast and beautiful: you can have it all. Phoenix creator Chris McCord, Elixir creator Jose Valim, and award-winning author Bruce Tate walk you through building an application that's fast and reliable. At every step, you'll learn from the Phoenix creators not just what to do, but why. Packed with insider insights, this definitive guide will be your constant companion in your journey from Phoenix novice to expert, as you build the next generation of web applications. Phoenix is the long-awaited web framework based on Elixir, the highly concurrent language that combines a beautiful syntax with rich metaprogramming. The authors, who developed the earliest production Phoenix applications, will show you how to create code that's easier to write, test, understand, and maintain. The best way to learn Phoenix is to code, and you'll get to attack some interesting problems. Start working with controllers, views, and templates within the first few pages. Build an in-memory repository, and then back it with an Ecto database layer. Learn to use change sets and constraints that keep readers informed and your database integrity intact. Craft your own interactive application based on the channels API for the real-time, high-performance applications that this ecosystem made famous. Write your own authentication components called plugs, and even learn to use the OTP layer for monitored, reliable services. Organize your code with umbrella projects so you can keep your applications modular and easy to maintain. This is a book by developers and for developers, and we know how to help you ramp up quickly. Any book can tell you what to do. When you've finished this one, you'll also know why to do it. What You Need: To work through this book, you will need a computer capable of running Erlang 17 or better, Elixir 1.1, or better, Phoenix 1.0 or better, and Ecto 1.0 or better. A rudimentary knowledge of Elixir is also highly recommended.
    """,
    link: "link"
  },
  %Book{
    title: "Programming Elixir",
    isbn: "9781937785581",
    author: ["Dave Thomas"],
    publisher: "Pragmatic Bookshelf",
    thumbnail: "https://books.google.es/books/content?id=yLBAjgEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE73OFxV1rz4Y-3pzBu5NP7q8B5WVveLW0VPkp84S2GuJbAcJkpywCQzfyzRjm4u9jYQr2eXi8cjwgUa5sgyVNTd74plLg1X-nMN1JzyZkhA_jH04VglRFdCQa8B2Z4akSMv_ReOO&source=gbs_api",
    description: """
    Don't accept the compromise between fast and beautiful: you can have it all. Phoenix creator Chris McCord, Elixir creator Jose Valim, and award-winning author Bruce Tate walk you through building an application that's fast and reliable. At every step, you'll learn from the Phoenix creators not just what to do, but why. Packed with insider insights, this definitive guide will be your constant companion in your journey from Phoenix novice to expert, as you build the next generation of web applications. Phoenix is the long-awaited web framework based on Elixir, the highly concurrent language that combines a beautiful syntax with rich metaprogramming. The authors, who developed the earliest production Phoenix applications, will show you how to create code that's easier to write, test, understand, and maintain. The best way to learn Phoenix is to code, and you'll get to attack some interesting problems. Start working with controllers, views, and templates within the first few pages. Build an in-memory repository, and then back it with an Ecto database layer. Learn to use change sets and constraints that keep readers informed and your database integrity intact. Craft your own interactive application based on the channels API for the real-time, high-performance applications that this ecosystem made famous. Write your own authentication components called plugs, and even learn to use the OTP layer for monitored, reliable services. Organize your code with umbrella projects so you can keep your applications modular and easy to maintain. This is a book by developers and for developers, and we know how to help you ramp up quickly. Any book can tell you what to do. When you've finished this one, you'll also know why to do it. What You Need: To work through this book, you will need a computer capable of running Erlang 17 or better, Elixir 1.1, or better, Phoenix 1.0 or better, and Ecto 1.0 or better. A rudimentary knowledge of Elixir is also highly recommended.
    """,
    link: "link"
  },
  %Book{
    title: "Programming Phoenix",
    isbn: "9781680501452",
    author: ["Chris McCord", "Bruce Tate", "José Valim"],
    publisher: "Pragmatic Bookshelf",
    thumbnail: "https://books.google.es/books/content?id=yLBAjgEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE73OFxV1rz4Y-3pzBu5NP7q8B5WVveLW0VPkp84S2GuJbAcJkpywCQzfyzRjm4u9jYQr2eXi8cjwgUa5sgyVNTd74plLg1X-nMN1JzyZkhA_jH04VglRFdCQa8B2Z4akSMv_ReOO&source=gbs_api",
    description: """
    Don't accept the compromise between fast and beautiful: you can have it all. Phoenix creator Chris McCord, Elixir creator Jose Valim, and award-winning author Bruce Tate walk you through building an application that's fast and reliable. At every step, you'll learn from the Phoenix creators not just what to do, but why. Packed with insider insights, this definitive guide will be your constant companion in your journey from Phoenix novice to expert, as you build the next generation of web applications. Phoenix is the long-awaited web framework based on Elixir, the highly concurrent language that combines a beautiful syntax with rich metaprogramming. The authors, who developed the earliest production Phoenix applications, will show you how to create code that's easier to write, test, understand, and maintain. The best way to learn Phoenix is to code, and you'll get to attack some interesting problems. Start working with controllers, views, and templates within the first few pages. Build an in-memory repository, and then back it with an Ecto database layer. Learn to use change sets and constraints that keep readers informed and your database integrity intact. Craft your own interactive application based on the channels API for the real-time, high-performance applications that this ecosystem made famous. Write your own authentication components called plugs, and even learn to use the OTP layer for monitored, reliable services. Organize your code with umbrella projects so you can keep your applications modular and easy to maintain. This is a book by developers and for developers, and we know how to help you ramp up quickly. Any book can tell you what to do. When you've finished this one, you'll also know why to do it. What You Need: To work through this book, you will need a computer capable of running Erlang 17 or better, Elixir 1.1, or better, Phoenix 1.0 or better, and Ecto 1.0 or better. A rudimentary knowledge of Elixir is also highly recommended.
    """,
    link: "link"
  }
]

Repo.delete_all(from book in "books")
Enum.each(books, fn (book) -> Repo.insert!(book) end)
