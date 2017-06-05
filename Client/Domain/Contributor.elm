module Domain.Contributor exposing (..)

import Domain.Core exposing (..)
import Controls.ProfileThumbnail as ProfileThumbnail exposing (..)
import Settings exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { profile : Profile
    , topics : List Topic
    , articles : List Post
    , videos : List Post
    , podcasts : List Post
    }


model : Model
model =
    { profile = Profile (Id undefined) (Contributor undefined) (Url undefined) undefined []
    , topics = []
    , articles = []
    , videos = []
    , podcasts = []
    }


type Msg
    = TopicsSelected
    | ArticlesSelected
    | VideosSelected
    | PodcastsSelected
    | None ProfileThumbnail.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        TopicsSelected ->
            { model | topics = [] }

        ArticlesSelected ->
            { model | articles = runtime.latestPosts model.profile.id Article }

        VideosSelected ->
            { model | videos = runtime.latestPosts model.profile.id Video }

        PodcastsSelected ->
            { model | podcasts = runtime.latestPosts model.profile.id Podcast }

        None subMsg ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ table []
            [ tr []
                [ table []
                    [ tr []
                        [ td [] [ img [ src <| getUrl <| model.profile.imageUrl, width 100, height 100 ] [] ]
                        , td []
                            [ topicsUI model.profile.topics ]
                        , table []
                            [ tr [] [ td [] [ b [] [ text "Videos" ] ] ]
                            , div [] (contentUI (runtime.getContent model.profile.id Video))
                            , tr [] [ td [] [ b [] [ text "Podcasts" ] ] ]
                            , div [] (contentUI (runtime.getContent model.profile.id Podcast))
                            , tr [] [ td [] [ b [] [ text "Articles" ] ] ]
                            , div [] (contentUI (runtime.getContent model.profile.id Article))
                            ]
                        ]
                    , tr [] [ td [] [ text <| getName model.profile.name ] ]
                    , tr [] [ td [] [ p [] [ text model.profile.bio ] ] ]
                    ]
                ]
            ]
        ]


contentUI : List Post -> List (Html Msg)
contentUI videos =
    videos |> List.map (\post -> a [ href <| getUrl post.url ] [ text <| getTitle post.title, br [] [] ])


topicsUI : List Topic -> Html Msg
topicsUI topics =
    let
        formattedTopics =
            topics |> List.map (\t -> div [] [ input [ type_ "submit", value <| getTopic t ] [] ])
    in
        div [] formattedTopics
