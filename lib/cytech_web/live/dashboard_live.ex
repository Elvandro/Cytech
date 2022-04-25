defmodule CytechWeb.DashboardLive do
  use CytechWeb, :live_view

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>LiveView is awesome!</h1>
    """
  end

  def authenticate_api() do
    url = "https://vrmapi.victronenergy.com/v2/auth/login"

    payload =
      Poison.encode!(%{
        username: "dennislubanga662@gmail.com",
        password: "Arshavin@23"
      })

    headers = [{"Content-type", "application/json"}]

    case HTTPoison.post(url, payload, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        res = Poison.decode!(body)
        # get_victron_data(res["idUser"], res["token"])
        get_victron_data_extended(res["idUser"], res["token"])

      # IO.inspect(res)

      {:ok, %HTTPoison.Response{status_code: _status_code, body: _body} = status} ->
        IO.inspect(status)

      {:error, %HTTPoison.Error{reason: _reason} = error} ->
        IO.inspect(error)
    end
  end

  def get_victron_data(user_id, token) do
    url = "https://vrmapi.victronenergy.com/v2/users/#{user_id}/installations"

    headers = [
      {"Content-type", "application/json"},
      {"x-authorization", "Bearer #{token}"}
    ]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: _status_code, body: body} = status} ->
        IO.inspect(status)
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason} = e} ->
        IO.inspect(e)
        {:error, reason}
    end
  end


  def get_victron_data_extended(user_id, token) do
    url = "https://vrmapi.victronenergy.com/v2/users/#{user_id}/installations?extended=1"

    headers = [
      {"Content-type", "application/json"},
      {"x-authorization", "Bearer #{token}"}
    ]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: _status_code, body: body} = status} ->
        IO.inspect(status)
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason} = e} ->
        IO.inspect(e)
        {:error, reason}
    end
  end

  # def create_pesaflow_invoice(payment, send_reminder? \\ true) do
  #   token = Common.generate_token()

  #   headers = [
  #     {"Content-type", "application/json"},
  #     {"Authorization", "Bearer #{token}"}
  #   ]

  #   case HTTPoison.post(
  #          Setting.get_setting!("pesaflow_checkout_url"),
  #          pesaflow_invoice_payload(payment, send_reminder?),
  #          headers,
  #          []
  #        ) do
  #     {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
  #       Poison.decode!(body)
  #       |> set_invoice_number(payment)

  #     {:ok, %HTTPoison.Response{status_code: _status_code, body: body} = status} ->
  #       IO.inspect(status)
  #       Logger.warn("#{inspect(status)}")
  #       {:error, body}

  #     {:error, %HTTPoison.Error{reason: reason} = e} ->
  #       IO.inspect(e)
  #       Logger.error("Error: #{inspect(e)}")
  #       {:error, reason}
  #   end
  # end

  # def get_payment_status_from_pesaflow(invoice_number) do
  #   url = "#{Setting.get_setting!("pesaflow_invoice_status_url")}=#{invoice_number}"

  #   case HTTPoison.get(url) |> IO.inspect() do
  #     {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
  #       {:ok, Poison.decode!(body)}

  #     {:ok, %HTTPoison.Response{status_code: _status_code, body: body} = status} ->
  #       IO.inspect(status)
  #       Logger.warn("#{inspect(status)}")
  #       {:error, body}

  #     {:error, %HTTPoison.Error{reason: reason} = e} ->
  #       IO.inspect(e)
  #       Logger.error("Error: #{inspect(e)}")
  #       {:error, reason}
  #   end
end
