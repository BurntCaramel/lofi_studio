defmodule LofiPlayWeb.JourneyView do
  use LofiPlayWeb, :view
  alias LofiPlay.Preview.Bootstrap
  alias LofiPlay.Content

  @sign_up_lofi """
  Email #email
  Password #password
  Create account #button #primary
  """

  defp preview_element({:screen, %{"screen" => {:flag, true}, "sign-up" => {:flag, true}}}, components) do
    #"sign up"
    Bootstrap.preview_text(@sign_up_lofi, "", components)
  end

  defp preview_element({:screen, tags}, components) do
    keys = Map.keys(tags)
    tag = case keys do
      ["screen", tag] -> tag
      [tag, "screen"] -> tag
      _ -> nil
    end
    
    if is_nil(tag) do
      "No #screen found"
    else
      case Content.get_screen_by_tag("##{tag}") do
        nil ->
          "No #screen found"
        screen ->
          #screen.body
          Bootstrap.preview_text(screen.body, "", components)
      end
    end
  end

  defp preview_element({:story, children}, components) do
    "User story"
  end

  defp preview_element({:message, tags}, components) do
    "message"
  end

  defp preview_element({:text, texts}, components) do
    "text"
  end

  # Preview with default/random values
  def preview(journey, components: components) do
    #Bootstrap.preview_text(journey.body, "", components)
    #""
    LofiPlay.Preview.Journeys.preview_content(journey.body, &preview_element(&1, components))
  end

  def preview_in_iframe(conn, journey, layout) do
    content_tag(:iframe, "", class: "journey-preview-iframe", src: journey_preview_path(conn, :show, journey, layout: layout), style: "width: 100%; border: none;")
  end
end
