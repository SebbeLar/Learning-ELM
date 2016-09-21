module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String

-- model

type alias Model =
    { players : List Player
    , name : String
    , playerId : Maybe Int
    , plays : List Play
    }

type alias Player =
    { id : Int
    , name : String
    , points : Int
    }

type alias Play =
    { id : Int
    , playerId : Int
    , name : String
    , points : Int
    }

model : Model
model =
    { players = []
    , name = ""
    , playerId = Nothing
    , plays = []
    }

-- update

type Msg
    = Edit Player
    | Score Player Int
    | Input String
    | Save
    | Cancel
    | DeletePlay Play

update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            { model | name = name }
        
        Cancel ->
            { model | name = "", playerId = Nothing }

        Save ->
            if (String.isEmpty model.name) then
                model
            else
                save model
        _ ->
            model    

save : Model -> Model
save model =
    case model.playerId of
        Just id ->
            edit model id

        Nothing ->
            add model

edit : Model -> Int -> Model
edit model id =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == id then
                        { player | name = model.name }
                    else
                        player
                    )
                    model.players
        newPlays =
            List.map
                (\play ->
                    if play.playerId == id then
                        { play | name = model.name }
                    else
                        play
                )
                model.plays
    in
        { model
            | players = newPlayers
            , plays = newPlays
            , name = ""
            , playerId = Nothing
        }

add : Model -> Model
add model =
    let
        -- We are making a new Player
        -- Player (List.length model.players) model.name 0 is short for
        -- player =
        -- { id = (List.length model.players)
        -- , name = model.name
        -- , points = 0
        -- }
        player =
            Player (List.length model.players) model.name 0

        -- Next we need to add our Player to our List of players
        -- we can add to a List with either append ( ++ ) which adds it to the end of a List.
        -- or with cons ( :: ) which adds it to the begining of a List which is the fastest operation
        newPlayers =
            player :: model.players

    in
        { model
            | players = newPlayers
            , name = ""
        }
-- view


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score Keeper" ]
        , playerForm model
        , div [] [text (toString model)]
        ]

playerForm : Model -> Html Msg
playerForm model =
   Html.form [ onSubmit Save ]
        [ input
            [ type' "text"
            , placeholder "Add/Edit Player..."
            , onInput Input
            , value model.name
            ]
            []
        , button [ type' "submit" ] [ text "Save" ]
        , button [ type' "button", onClick Cancel ] [ text "Cancel" ]  
        ]

main : Program Never 
main =
    App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
   