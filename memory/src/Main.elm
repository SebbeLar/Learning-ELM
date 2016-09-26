module Main exposing (..)

import Html exposing (..)
import Html.App as App


type alias Model =
    { cards : List Card
    }


type alias Card =
    { id : Int
    , text : String
    }


type Msg
    = TurnCard


update : Msg -> Model -> Model
update msg model =
    case msg of
        TurnCard ->
            model


model : Model
model =
    { cards =
        [ { id = 0, text = "A" }
        , { id = 1, text = "B" }
        ]
    }


view : Model -> Html Msg
view model =
    div []
        [ cardSection model ]


cardSection : Model -> Html Msg
cardSection model =
    div []
        [ text "cardSection" ]


main : Program Never
main =
    App.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
