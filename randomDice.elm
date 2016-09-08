import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Random



main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFaceA : Int
  , dieFaceB : Int
  }


init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)



-- UPDATE


type Msg
  = Roll
  | NewFaceA Int
  | NewFaceB Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFaceA (Random.int 1 6))

    NewFaceA newFace ->
      ({ model | dieFaceA = newFace }, Random.generate NewFaceB (Random.int 1 6))

    NewFaceB newFace ->
      ({ model | dieFaceB = newFace }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieFaceA) ]
    , h1 [] [ text (toString model.dieFaceB) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]
