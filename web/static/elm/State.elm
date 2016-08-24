module State exposing (..)

import BookSearch.State
import Phoenix.Socket as Socket
import Dict exposing (Dict)
import Types exposing (..)
import Phoenix exposing (phxInit)
import Routing exposing (routeFromResult)


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            routeFromResult result

        ( phxSocket, phxCmd ) =
            phxInit currentRoute

        model =
            { searchPageModel = BookSearch.State.init
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
        LoadBooks books ->
            ( { model
                | books =
                    books
                        |> List.map (\book -> ( .id book, book ))
                        |> Dict.fromList
              }
            , Cmd.none
            )

        BookSearchMsg msg ->
            let
                ( searchPageModel, searchPageCmd ) =
                    BookSearch.State.update msg model.searchPageModel
            in
                ( { model | searchPageModel = searchPageModel }, Cmd.none )

        JoinAllBooksChannel ->
            Debug.log "Joined to books:*"
                ( model, Cmd.none )

        PhoenixMsg msg ->
            let
                ( phxSocket, phxCmd ) =
                    Socket.update msg model.phxSocket
            in
                ( { model | phxSocket = phxSocket }
                , Cmd.map PhoenixMsg phxCmd
                )


subscriptions : Model -> Sub Msg
subscriptions model =
    Socket.listen model.phxSocket PhoenixMsg


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    ( { model | route = routeFromResult result }, Cmd.none )
