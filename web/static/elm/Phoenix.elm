module Phoenix exposing (..)

import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Book.Json exposing (..)
import Types exposing (..)
import Config


booksChannel : Channel.Channel Msg
booksChannel =
    Channel.init "book:*"
        |> Channel.onJoin (\_ -> JoinAllBooksChannel)


joinBooks : Socket.Socket Msg -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
joinBooks socket =
    socket
        |> Socket.on "join_all_books" "book:*" (parseBooks >> LoadBooks)
        |> Socket.join booksChannel


phxSocket : Socket.Socket Msg
phxSocket =
    Socket.init Config.socketServer


phxInit : Route -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
phxInit route =
    case route of
        _ ->
            phxSocket |> joinBooks
