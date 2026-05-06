defmodule GestionArchivos do
  def leer() do
    case File.read("datos/socios.csv") do
      {:ok,contenido} ->
        String.split(contenido,"\n")
        |>Enum.map(fn linea ->
          [cedula,nombre,edad,clases] = String.split(linea, ",")
          lista_clases=String.split(clases,";")
          {cedula, %Socio{nombre: nombre,edad: String.to_integer(edad),clases: lista_clases}} end)
          |> Map.new()
      {:error,_} -> %{}
    end
  end

  def escribir(mapa) do
    csv= Enum.map(mapa, fn {cedula,socio} ->
      clases=Enum.join(socio.clases,";")
      "#{cedula},#{socio.nombre},#{socio.edad},#{clases}" end)
      |>Enum.join("\n")

    File.write("datos/socios.csv",csv)
  end
end
