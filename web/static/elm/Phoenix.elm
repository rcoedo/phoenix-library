module Phoenix exposing (..)

import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Phoenix.Push as Push
import Book.Json exposing (..)
import Json.Encode as Encode
import Types exposing (..)


socketServer : String
socketServer =
    "ws://localhost:4000/socket/websocket"


mapSocket :
    (Socket.Socket Msg -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) ))
    -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
    -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
mapSocket f scktCmd =
    let
        ( socket, cmd ) =
            scktCmd

        ( resultSocket, cmd2 ) =
            f socket
    in
        ( resultSocket, Cmd.batch ([ cmd, cmd2 ]) )


booksChannel : Channel.Channel Msg
booksChannel =
    Channel.init "books:*"
        |> Channel.onJoin (\_ -> JoinBooksChannel)


bookChannel : Int -> Channel.Channel Msg
bookChannel bookId =
    let
        channel =
            "books:" ++ (toString bookId)
    in
        Channel.init channel
            |> Channel.onJoin (\_ -> JoinBookChannel bookId)


joinBooks : Socket.Socket Msg -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
joinBooks socket =
    socket
        |> Socket.on "books" "books:*" (parseBooksResponse >> LoadBooks)
        |> Socket.join booksChannel


joinBook : Int -> Socket.Socket Msg -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
joinBook id socket =
    socket
        |> Socket.on "book" ("books:" ++ toString id) (parseBookResponse >> LoadBook)
        |> Socket.join (bookChannel id)


getBooks : Socket.Socket Msg -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
getBooks socket =
    socket
        |> Socket.push (Push.init "get_books" "books:*")


getBook : Int -> Socket.Socket Msg -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
getBook id socket =
    let
        payload =
            Encode.object [ ( "id", Encode.int id ) ]

        message =
            Push.init "get_book" ("books:" ++ toString id)
                |> Push.withPayload payload
    in
        Socket.push message socket


phxSocket : Socket.Socket Msg
phxSocket =
    Socket.init socketServer


phxInit : Route -> ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
phxInit route =
    case route of
        _ ->
            ( phxSocket, Cmd.none ) |> mapSocket joinBooks
