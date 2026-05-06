defmodule GestionArchivos do

  def leer() do
    case File.read("datos/productos.json") do
      {:ok, contenido} ->
        Jason.decode!(contenido)
        |> Enum.map(fn {codigo, producto} ->
          {
            codigo,
            %Producto{
              nombre: producto["nombre"],
              precio: producto["precio"],
              cantidad: producto["cantidad"]
            }
          }
        end)
        |> Map.new()

      {:error, _} ->
        %{}
    end
  end

  def escribir(mapa) do
    json=Enum.map(mapa,fn {codigo, prod} ->
        {
          codigo,
          %{
            nombre: prod.nombre,
            precio: prod.precio,
            cantidad: prod.cantidad
          }
        }
      end)
      |> Map.new()
      |> Jason.encode!(pretty: true)

    File.write("datos/productos.json", json)
  end

end
