defmodule Producto do
  @enforce_keys [:nombre, :precio, :cantidad]
  defstruct [:nombre, :precio, :cantidad]

  def nuevo(nombre, precio, cantidad) do
    cond do
      not Regex.match?(~r/^[a-zA-Z]+$/, nombre)->
        {:error, :nombre_invalido}

      not precio >=0 ->
        {:error, :precio_invalido}

      not cantidad < 0 ->
        {:error, :cantidad_invalida}

      not is_integer(cantidad) ->
        {:error, :cantidad_debe_ser_entera}

      true ->
        {:ok, %_MODULE_{nombre: nombre, precio: precio, cantidad: cantidad}}
    end
  end
end
