# PhoenixLibrary

## System requirements

  * Have docker and docker-compose installed

## To start PhoenixLibrary

  1. docker-compose up -d db
  2. Execute bash in the web container with `$ make sh`
  3. Install node dependencies with `# npm install`
  4. Install elixir dependencies with `# mix deps.get`
  5. Create and migrate your database with `# mix ecto.create && mix.ecto.migrate`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## To do:

### First iteration

  - [ ] Make a landing page. It should have a search bar and a paginated (client-side) list with all the books. A search
        query will look for books matching isbn, title or author.
  - [ ] Book view. Shows all the book information.
  - [ ] Add book form. Books can have: isbn, title, a list of authors.
  - [ ] Edit book form. Should include a delete book button.
