module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Html.App as App


type alias Model =
    { cards : List Card
    , activeGame : Bool
    }


type alias Card =
    { id : Int
    , text : String
    , visable : Bool
    }


type Msg
    = TurnCard
    | StartGame


update : Msg -> Model -> Model
update msg model =
    case msg of
        TurnCard ->
            model

        StartGame ->
            { model | activeGame = not model.activeGame }


model : Model
model =
    { cards =
        [ { id = 0, text = "A", visable = False }
        , { id = 1, text = "B", visable = False }
        ]
    , activeGame = False
    }


view : Model -> Html Msg
view model =
    div []
        [ startGame model
        , cardSection model
        ]


startGame : Model -> Html Msg
startGame model =
    div []
        [ input [ type' "button", onClick StartGame ] [ text "New Game" ]
        ]


cardSection : Model -> Html Msg
cardSection model =
    let
        newCards =
            List.map
                (\c ->
                    List.repeat 2 c
                )
                model.cards
                |> List.concat
                |> randomize
    in
        newCards
            |> List.map card
            |> div [ class "container" ]

randomize : List a -> List a
randomize lis =
    let
        newList = []
            List.map
                (\x ->
                    rand = Random.int 0 1
                    
                    if (rand == 0) then
                        x ++ newList
                    else
                        x :: newList
                )
                lis
    in
        newList

card : Card -> Html Msg
card card =
    div [ class "card" ] [ text card.text ]


main : Program Never
main =
    App.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
