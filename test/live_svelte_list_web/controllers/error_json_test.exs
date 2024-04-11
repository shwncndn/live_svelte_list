defmodule LiveSvelteListWeb.ErrorJSONTest do
  use LiveSvelteListWeb.ConnCase, async: true

  test "renders 404" do
    assert LiveSvelteListWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert LiveSvelteListWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
