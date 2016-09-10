module State exposing (..)

import Pages.BookSearch.State as BookSearchState
import Pages.BookDetails.State as BookDetailsState
import Phoenix.Socket as Socket
import Dict exposing (Dict)
import Types exposing (..)
import Phoenix exposing (phxInit)
import Routing exposing (routeFromResult)
import Init exposing (books)
import Debug


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            result |> routeFromResult

        ( phxSocket, phxCmd ) =
            phxInit currentRoute

        model =
            { searchPageModel = BookSearchState.init
            , detailsPageModel = BookDetailsState.init
            , books = Dict.fromList []
            , route = currentRoute
            , phxSocket = phxSocket
            }

        cmd =
            Cmd.map PhoenixMsg phxCmd
    in
        ( model, cmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        LoadBook book ->
            case book of
                Just book ->
                    ( { model
                        | books =
                            model.books
                                |> Dict.insert book.id book
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( model, Cmd.none )

        LoadBooks books ->
            ( { model
                | books =
                    books
                        |> List.map (\book -> ( .id book, book ))
                        |> Dict.fromList
              }
            , Cmd.none
            )

        UpdateBook book ->
            model |> Debug.log "UPDATE BOOK"

        BookSearchMsg msg ->
            let
                ( searchPageModel, searchPageCmd ) =
                    BookSearchState.update msg model.searchPageModel
            in
                ( { model | searchPageModel = searchPageModel }, Cmd.map BookSearchMsg searchPageCmd )

        BookDetailsMsg msg ->
            let
                ( detailsPageModel, detailsPageCmd ) =
                    BookDetailsState.update msg model.detailsPageModel
            in
                ( { model | detailsPageModel = detailsPageModel }, Cmd.map BookDetailsMsg detailsPageCmd ) |> Debug.log "awesome!"

        PhoenixMsg msg ->
            let
                ( phxSocket, phxCmd ) =
                    Socket.update msg model.phxSocket
            in
                ( { model | phxSocket = phxSocket }
                , Cmd.map PhoenixMsg phxCmd
                )

        _ ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Socket.listen model.phxSocket PhoenixMsg
        , books LoadBooks
        ]


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    ( { model | route = routeFromResult result }, Cmd.none )
