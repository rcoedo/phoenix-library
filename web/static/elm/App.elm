module App exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Json.Encode as Encode
import Json.Decode as Decode exposing ((:=))
import String
import Result
import Regex


-- Constants


socketServer : String
socketServer =
    "ws://localhost:4000/socket/websocket"



-- Model


type alias Model =
    { inputModel : String
    , books : Dict Int Book
    , phxSocket : Socket.Socket Msg
    }


type alias Book =
    { id : Int
    , title : String
    , isbn : String
    , thumbnail : String
    , author : List String
    }


books : Dict Int Book
books =
    Dict.fromList []


bookDecoder : Decode.Decoder Book
bookDecoder =
    Decode.object5 Book
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("isbn" := Decode.string)
        ("thumbnail" := Decode.string)
        ("author" := Decode.list Decode.string)


bookListDecoder : Decode.Decoder (List Book)
bookListDecoder =
    Decode.object1 identity ("books" := (Decode.list bookDecoder))


parseBooks : Encode.Value -> List Book
parseBooks value =
    value
        |> Decode.decodeValue bookListDecoder
        |> Result.toMaybe
        |> Maybe.withDefault []


booksChannel : Channel.Channel Msg
booksChannel =
    Channel.init "book:*"
        |> Channel.onJoin (\_ -> JoinBooksChannel)


initPhoenix : ( Socket.Socket Msg, Cmd (Socket.Msg Msg) )
initPhoenix =
    Socket.init socketServer
        |> Socket.withDebug
        |> Socket.on "join_all_books" "book:*" (parseBooks >> InitBooks)
        |> Socket.join booksChannel


init : ( Model, Cmd Msg )
init =
    let
        ( phxSocket, phxCmd ) =
            initPhoenix

        model =
            { inputModel = ""
            , books = books
            , phxSocket = phxSocket
            }

        cmd =
            Cmd.map PhoenixMsg phxCmd
    in
        ( model, cmd )



-- Model Helpers


authorString : Book -> String
authorString book =
    (String.join ", " << .author) book


filterRegex : String -> String -> Bool
filterRegex query =
    query
        |> Regex.regex
        >> Regex.caseInsensitive
        >> Regex.contains


filterElement : List (a -> String) -> String -> a -> Bool
filterElement getters query element =
    getters
        |> List.map (\getter -> getter element)
        |> List.map (filterRegex query)
        |> List.foldl (||) False


getResults : Model -> List Book
getResults model =
    let
        query =
            .inputModel model
    in
        model
            |> .books
            |> Dict.values
            |> List.filter (filterElement [ authorString, .title, .isbn ] query)


shorten : Int -> String -> String
shorten n str =
    if String.length str > n then
        str |> String.slice 0 n >> (\s -> String.append s "...")
    else
        str


shortAuthor : Int -> Book -> String
shortAuthor n book =
    book |> authorString |> shorten n


shortTitle : Int -> Book -> String
shortTitle n book =
    book |> .title |> shorten n



-- Update


type Msg
    = Input String
    | JoinBooksChannel
    | InitBooks (List Book)
    | PhoenixMsg (Socket.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Input value ->
            ( { model | inputModel = value }, Cmd.none )

        JoinBooksChannel ->
            ( model, Cmd.none )

        InitBooks books ->
            ( { model
                | books =
                    books
                        |> List.map (\book -> ( .id book, book ))
                        |> Dict.fromList
              }
            , Cmd.none
            )

        PhoenixMsg msg ->
            let
                ( phxSocket, phxCmd ) =
                    Socket.update msg model.phxSocket
            in
                ( { model | phxSocket = phxSocket }
                , Cmd.map PhoenixMsg phxCmd
                )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Socket.listen model.phxSocket PhoenixMsg



-- View


bookCardView : Book -> Html Msg
bookCardView book =
    div [ class "book-card" ]
        [ img [ class "book-card__image", src <| .thumbnail <| book ]
            []
        , div [ class "book-card__information" ]
            [ div [ class "book-card__title" ] [ text <| shortTitle 18 <| book ]
            , p [ class "book-card__author" ] [ text <| shortAuthor 25 <| book ]
            ]
        ]


bookListView : Model -> Html Msg
bookListView model =
    ul [ class "book-list" ]
        (model
            |> getResults
            >> List.map bookCardView
            >> List.map (\e -> li [ class "book-list__item" ] [ e ])
        )


inputView : Model -> Html Msg
inputView model =
    input
        [ class "book-search__input"
        , placeholder "Search an Isbn, Title or Author..."
        , onInput Input
        , type' "text"
        ]
        [ text <| .inputModel model ]


view : Model -> Html Msg
view model =
    div []
        [ div [ class "book-search" ] [ inputView model ]
        , bookListView model
        ]


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
