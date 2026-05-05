defmodule Gimnasio do
  
  def agregar_socio(socios, cedula, nombre, edad) do
    case Socio.nuevo(nombre, edad) do
      {:ok, nuevo_socio} ->
        if Map.has_key?(socios, cedula) do
          {:error, :cedula_duplicada}
        else
          {:ok, Map.put(socios, cedula, nuevo_socio)}
        end
      {:error, razon} ->
        {:error, razon}
    end
  end

  def eliminar_socio(socios, cedula) do
    if Map.has_key?(socios, cedula) do
      {:ok, Map.delete(socios, cedula)}
    else
      {:error, :no_encontrado}
    end
  end

  def obtener_socio(socios, cedula) do
    case Map.get(socios, cedula) do
      nil -> {:error, :no_encontrado}
      socio -> {:ok, socio}
    end
  end

  def actualizar_socio(socios, cedula, nombre, edad) do
    case Map.get(socios, cedula) do
      nil ->
        {:error, :no_encontrado}
      socio ->
        actualizado = %{socio | nombre: nombre, edad: edad}
        {:ok, Map.put(socios, cedula, actualizado)}
    end
  end

  def inscribir_clase(socios, cedula, clase) do
    case Map.get(socios, cedula) do
      nil ->
        {:error, :no_encontrado}
      socio ->
        case Socio.inscribir_clase(socio, clase) do
          {:ok, actualizado} ->
            {:ok, Map.put(socios, cedula, actualizado)}
          {:error, razon} ->
            {:error, razon}
        end
    end
  end

  def desinscribir_clase(socios, cedula, clase) do
    case Map.get(socios, cedula) do
      nil ->
        {:error, :no_encontrado}
      socio ->
        case Socio.desinscribir_clase(socio, clase) do
          {:ok, actualizado} ->
            {:ok, Map.put(socios, cedula, actualizado)}
        end
    end
  end

  def listar_socios(socios) when map_size(socios)==0, do: IO.puts("No hay socios inscritos en el sistema")

  def listar_socios(socios) do
    Enum.each(socios, fn{cedula, socio} -> IO.puts("Nombre: #{socio.nombre}, Cedula: #{cedula}") end)
  end

  def socios_en_clase(socios,_clase) when map_size(socios)==0, do: "No hay socios inscritos en esa clase"

  def socios_en_clase(socios, clase) do
    Enum.filter(socios,fn {_cedula,socio} -> Socio.tiene_clase?(socio,clase) end)
    |>listar_socios()
  end

end
