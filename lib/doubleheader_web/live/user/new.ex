defmodule DoubleheaderWeb.UserLive.New do
  use DoubleheaderWeb, :live_view

  alias Doubleheader.Accounts
  alias Doubleheader.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    assigns = [
      trigger_submit: false,
      changeset: Accounts.change_user_registration(%User{})
    ]
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
  ~L"""
  <section class="is-fullheight">
    <figure class="pt-5 px-5 container has-text-centered">
      <img src="<%= Routes.static_path(@socket, "/images/doubleheader-banner-full.png") %>">
    </figure>
    <div class="hero-body">
      <div class="container">
        <div class="column is-4 is-offset-4">
          <h3 class="title has-text-black-bis has-text-centered"> Register </h3>
          <p class="subtitle has-text-grey has-text-centered"> Please fill the form below. </p>
          <div class="box">
          <%= f = form_for @changeset, Routes.user_registration_path(@socket, :create), [phx_change: :validate, phx_submit: :save, phx_trigger_action: @trigger_submit] %>
            <%= input_large f, :first_name, [class: "fas fa-signature"] %>
            <%= input_large f, :last_name, [class: "fas fa-signature"] %>
            <%= input_large f, :email, [class: "fas fa-envelope"] %>
            <%= input_large f, :password, [class: "fas fa-lock"], [value: input_value(f, :password)] %>
            <%= submit "Register", disabled: !@changeset.valid?, phx_disable_with: "Saving...", class: "button is-block is-primary is-large is-fullwidth" %>
            </form>
            </div>
          <p class="has-text-grey has-text-centered"><a href="<%= Routes.user_session_path(@socket, :new) %>">Login</a> · <a href="/passwordReset">Forgot Password</a> · </p>
        </div>
      </div>
    </div>
  </section>
  """
  end

  @impl true
  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      %User{}
      |> Accounts.change_user_registration(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", params, socket) do
    changeset =
      %User{}
      |> Accounts.change_user_registration(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset, trigger_submit: true)}
  end
end
