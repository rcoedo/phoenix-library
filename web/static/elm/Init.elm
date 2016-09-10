port module Init exposing (..)

import Book.Types exposing (Book)


port books : (List Book -> msg) -> Sub msg
