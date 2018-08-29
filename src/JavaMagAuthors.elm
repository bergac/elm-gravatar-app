module JavaMagAuthors exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, at, string)
import Json.Decode.Pipeline as JsonPipeline
import MD5


{--We create a simple Elm element, so we use Browser.element.
   There are many other ways to create your Elm application.
   Take a look at to see some examples https://package.elm-lang.org/packages/elm/browser/1.0.0/
--}


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias AuthorRecord =
    { displayName : String
    , aboutMe : String
    , currentLocation : String
    , thumbnailUrl : String
    }


type alias Model =
    { newAuthorEmail : String
    , authors : List AuthorRecord
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" [], Cmd.none )



-- UPDATE


type Msg
    = AuthorEmail String
    | AddAuthor
    | GravatarProfile (Result Http.Error AuthorRecord)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AuthorEmail newEmail ->
            ( { model | newAuthorEmail = newEmail }, Cmd.none )

        AddAuthor ->
            ( model, getGravatarProfile model.newAuthorEmail )

        GravatarProfile (Ok authorProfile) ->
            ( { model | authors = authorProfile :: model.authors }
            , Cmd.none
            )

        GravatarProfile (Err _) ->
            -- Normally you would show some sort of error to the user
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Add authors to your Java Magazine article" ]
        , div [ class "add-author-form" ]
            [ input [ placeholder "Author Email address", onInput AuthorEmail ] []
            , button [ class "button-add", onClick AddAuthor ] [ text "Add Author" ]
            ]
        , div [ class "list-authors" ]
            [ img [ src (createIconUrl model.newAuthorEmail) ] []
            , div [] [ viewAuthorRecords model.authors ]
            ]
        ]


viewAuthorRecords : List AuthorRecord -> Html Msg
viewAuthorRecords authors =
    ul [] (List.map viewAuthorRecord authors)


viewAuthorRecord : AuthorRecord -> Html Msg
viewAuthorRecord author =
    li []
        [ img [ src author.thumbnailUrl ] []
        , p [] [ text ("Display name: " ++ author.displayName) ]
        , p [] [ text ("About me: " ++ author.aboutMe) ]
        , p [] [ text ("Location: " ++ author.currentLocation) ]
        ]



-- SUBSCRIPTIONS
{--Subscriptions can be used to listen to external input.
   Our code doesn't listen to anything, but we need it for the `init` function of Browser.element.
--}


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getGravatarProfile : String -> Cmd Msg
getGravatarProfile profileEmail =
    Http.send GravatarProfile
        (Http.get (createProfileUrl profileEmail) decodeGravatarResponse)


createProfileUrl : String -> String
createProfileUrl email =
    "https://en.gravatar.com/" ++ MD5.hex email ++ ".json"


createIconUrl : String -> String
createIconUrl email =
    "https://www.gravatar.com/avatar/" ++ MD5.hex email


decodeGravatarResponse : Decoder AuthorRecord
decodeGravatarResponse =
    let
        authorDecoder =
            Json.Decode.succeed AuthorRecord
                |> JsonPipeline.required "displayName" string
                |> JsonPipeline.optional "aboutMe" string "-"
                |> JsonPipeline.optional "currentLocation" string "-"
                |> JsonPipeline.required "thumbnailUrl" string
    in
    at [ "entry", "0" ] authorDecoder
