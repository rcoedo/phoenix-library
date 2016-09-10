module Types exposing (..)

import Dict exposing (Dict)
import Phoenix.Socket as Socket
import Book.Types exposing (Book)
import Pages.BookSearch.Types as BookSearchTypes
import Pages.BookDetails.Types as BookDetailsTypes


type Route
    = BookSearchRoute
    | BookRoute Int
    | NotFoundRoute


type Msg
    = BookSearchMsg BookSearchTypes.Msg
    | BookDetailsMsg BookDetailsTypes.Msg
    | LoadBooks (List Book)
    | LoadBook (Maybe Book)
    | UpdateBook Book
    | JoinBooksChannel
    | JoinBookChannel Int
    | PhoenixMsg (Socket.Msg Msg)


type alias Model =
    { searchPageModel : BookSearchTypes.Model
    , detailsPageModel : BookDetailsTypes.Model
    , route : Route
    , books : Dict Int Book
    , phxSocket : Socket.Socket Msg
    }
