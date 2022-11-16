module Main exposing (main)

import Browser
import Html exposing (Html)
import Html.Events as Events
import Nanoid exposing (Nanoid)
import Random


main : Program (List Int) Model Msg
main =
    Browser.element
        { init = \pool -> ( { pool = pool, currentID = Nothing }, Cmd.none )
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


type alias Model =
    { pool : List Int
    , currentID : Maybe Nanoid
    }


type Msg
    = GenerateNanoIDFromPoolClicked
    | GenerateNanoIDFromRandomClicked
    | NanoidGenerated Nanoid


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateNanoIDFromPoolClicked ->
            let
                currentPool =
                    List.take 21 model.pool

                updatedPool =
                    List.drop 21 model.pool
            in
            ( { model | pool = updatedPool, currentID = Just (Nanoid.nanoid currentPool) }
            , Cmd.none
            )

        GenerateNanoIDFromRandomClicked ->
            ( model, Random.generate NanoidGenerated Nanoid.generator )

        NanoidGenerated nanoid ->
            ( { model | currentID = Just nanoid }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h3
            []
            [ model.currentID
                |> Maybe.map (Nanoid.toString >> (++) "Current Nanoid: ")
                |> Maybe.withDefault "Click to generate an ID"
                |> Html.text
            ]
        , Html.div []
            [ Html.button
                [ Events.onClick GenerateNanoIDFromPoolClicked ]
                [ Html.text "Generate From Pool" ]
            ]
        , Html.div []
            [ Html.button
                [ Events.onClick GenerateNanoIDFromRandomClicked ]
                [ Html.text "Generate From Elm Random" ]
            ]
        ]
