defmodule CytechWeb.DashboardLive.Index do
  use CytechWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    data = authenticate_api()
    {:ok, assign(socket, :installations, data)}
  end

  def destructure(item) do
    item["extended"]
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
        res = Poison.decode!(body)
        res["records"]

      # IO.inspect(body)

      {:ok, %HTTPoison.Response{status_code: _status_code, body: body} = status} ->
        IO.inspect(status)
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason} = e} ->
        IO.inspect(e)
        {:error, reason}
    end
  end

  def authenticate_api_growatt() do
    # url = "http://server.growatt.com/login"

    url = "https://oss.growatt.com/login"

    payload =
      Poison.encode!(%{
        userName: "Dennis.lubanga",
        password: "Arshavin@23"
      })

    # headers = [{"Content-type", "application/json"}]

    case HTTPoison.post(url, payload) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        res = Poison.decode!(body)
        authenticate_api_growatt_v2()
        # get_victron_data(res["idUser"], res["token"])
        # get_victron_data_extended(res["idUser"], res["token"])

        IO.inspect(res)

      {:ok, %HTTPoison.Response{status_code: _status_code, body: _body} = status} ->
        IO.inspect(status)

      {:error, %HTTPoison.Error{reason: _reason} = error} ->
        IO.inspect(error)
    end
  end

  def authenticate_api_growatt_v2() do
    url = "https://server.growatt.com/login"

    payload =
      Poison.encode!(%{
        userName: "Dennis.lubanga",
        password: "Arshavin@23",
        lang: "en",
        loginTime: "2022-04-26 16:50:20",
        noRecord: true
      })

    # headers = [{"Content-type", "application/json"}]

    case HTTPoison.post(url, payload) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        res = Poison.decode!(body)
        # get_growat()
        # get_victron_data(res["idUser"], res["token"])
        # get_victron_data_extended(res["idUser"], res["token"])

        IO.inspect(res)

      {:ok, %HTTPoison.Response{status_code: _status_code, body: _body} = status} ->
        IO.inspect(status)

      {:error, %HTTPoison.Error{reason: _reason} = error} ->
        IO.inspect(error)
    end
  end

  # userName: Dennis.lubanga
  # password: Arshavin@23
  # lang: en
  # loginTime: 2022-04-26 16:50:20
  # noRecord: true

  def get_growat() do
    url = "https://server.growatt.com/panel/getDevicesByPlantList"

    payload =
      Poison.encode!(%{
        currPage: 1,
        plantId: 423_608
      })

    headers = [
      {"Content-type", "application/json"}
      # {"x-authorization", "Bearer #{token}"}
    ]

    case HTTPoison.post(url, payload, headers, []) do
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

  def authenticate_api_sma() do
    client_id = "dennislubanga662@gmail.com"
    response_type = "code"
    # redirect_uri = ""
    # state = ""
    url =
      "https://auth.smaapis.de/oauth2/auth?client_id=#{client_id}&response_type=#{response_type}"

    # payload =
    #   Poison.encode!(%{
    #     username: "dennislubanga662@gmail.com",
    #     password: "Arshavin@23"
    #   })

    # headers = [{"Content-type", "application/json"}]

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        res = Poison.decode!(body)
        # get_victron_data(res["idUser"], res["token"])
        # get_victron_data_extended(res["idUser"], res["token"])

        IO.inspect(res)

      {:ok, %HTTPoison.Response{status_code: _status_code, body: _body} = status} ->
        IO.inspect(status)

      {:error, %HTTPoison.Error{reason: _reason} = error} ->
        IO.inspect(error)
    end
  end

  def authenticate_api_fronius() do
    # url = "https://www.solarweb.com/"
    url = "https://api.solarweb.com/swqapi/iam/jwt"

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
        # get_victron_data_extended(res["idUser"], res["token"])

        IO.inspect(res)

      {:ok, %HTTPoison.Response{status_code: _status_code, body: _body} = status} ->
        IO.inspect(status)

      {:error, %HTTPoison.Error{reason: _reason} = error} ->
        IO.inspect(error)
    end
  end

  def get_fronius_data() do
    url = "https://login.fronius.com/logincontext"

    # url = "https://login.fronius.com/logincontext?sessionDataKey=ee9e63fd-9170-4ca2-8062-1b2346f37057&relyingParty=mf_o9iTAyKemNLQTa6Sp6HYonCIa&tenantDomain=carbon.super&preventCache=1651062116512"

    # headers = [{"Content-type", "application/json"}]

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        res = Poison.decode!(body)
        # get_victron_data(res["idUser"], res["token"])
        # get_victron_data_extended(res["idUser"], res["token"])
        IO.inspect(res)
        get_pvc_fronius_data()

      {:ok, %HTTPoison.Response{status_code: _status_code, body: _body} = status} ->
        IO.inspect(status)

      {:error, %HTTPoison.Error{reason: _reason} = error} ->
        IO.inspect(error)
    end
  end

  def get_pvc_fronius_data() do
    # url = "https://www.solarweb.com/PvSystemImages/GetUrlsForPark?_=1651062199537"
    url = "https://www.solarweb.com/solar_api/v1/GetInverterRealtimeData.cgi"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        res = Poison.decode!(body)
        # get_victron_data(res["idUser"], res["token"])
        # get_victron_data_extended(res["idUser"], res["token"])

        IO.inspect(res)

      {:ok, %HTTPoison.Response{status_code: _status_code, body: _body} = status} ->
        IO.inspect(status)

      {:error, %HTTPoison.Error{reason: _reason} = error} ->
        IO.inspect(error)
    end
  end

  #

  # https://auth.smaapis.de/oauth2/auth

  # https://sandbox.smaapis.de/oauth2/auth

  # https://server.growatt.com/login

  # https://login.fronius.com/

  # https://www.solarweb.com/
end
