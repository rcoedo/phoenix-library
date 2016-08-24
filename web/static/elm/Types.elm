module Types exposing (..)

import Dict exposing (Dict)
import Phoenix.Socket as Socket
import Book.Types exposing (Book)
import BookSearch.Types


type Route
    = BookSearchRoute
    | NotFoundRoute


type Msg
    = BookSearchMsg BookSearch.Types.Msg
    | LoadBooks (List Book)
    | JoinAllBooksChannel
    | PhoenixMsg (Socket.Msg Msg)


type alias Model =
    { searchPageModel : BookSearch.Types.Model
    , route : Route
    , books : Dict Int Book
    , phxSocket : Socket.Socket Msg
    }
