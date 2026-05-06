defmodule Inventario do

  def inicializar() do
    GestionArchivos.leer()
  end

  def agregar_producto(productos, codigo, nombre, precio, cantidad) do
    case Producto.nuevo(nombre,precio,cantidad) do
      {:ok, nuevo_producto} ->
        cond do
          Map.has_key?(productos, codigo) ->
            {:error, :codigo_repetido}
          String.length(codigo)>5 ->
            {:error, :codigo_invalido}
          true ->
            nuevo = Map.put(productos,codigo,nuevo_producto)
            GestionArchivos.escribir(nuevo)
            {:ok, nuevo}
        end
      {:error, razon} ->
        {:error, razon}
    end
  end

  def eliminar_producto(productos, codigo) do
    if Map.has_key?(productos, codigo) do
      nuevo=Map.delete(productos, codigo)
      GestionArchivos.escribir(nuevo)
      {:ok, nuevo}
    else
      {:error, :no_encontrado}
    end
  end

  def obtener_producto(productos, codigo) do
    case Map.get(productos, codigo) do
      nil -> {:error, :no_encontrado}
      producto -> {:ok, producto}
    end
  end

  def actualizar_producto(productos, codigo, nombre, precio, cantidad) do
    case Map.get(productos, codigo) do
      nil ->
        {:error, :no_encontrado}
      producto ->
        actualizado = %{producto | nombre: nombre, precio: precio, cantidad: cantidad}
        nuevo=Map.put(productos,codigo,actualizado)
        GestionArchivos.escribir(nuevo)
        {:ok, nuevo}
    end
  end

  def listar_productos(productos) when map_size(productos)==0, do: IO.puts("No hay productos inscritos en el inventario")

  def listar_productos(productos) do
    Enum.each(productos, fn{codigo, producto} -> IO.puts("Codigo: #{codigo} Nombre: #{producto.nombre}, Precio #{producto.precio}, Cantidad #{producto.cantidad}") end)
  end

  def productos_mas_2_vocales(productos) do
    Enum.filter(productos, fn {_codigo,producto} -> contar_vocales(producto.nombre)>=2 end)
      |>Enum.map(fn {codigo,producto}->{codigo,producto.nombre} end)
  end

  defp contar_vocales(""), do: 0
  defp contar_vocales(cadena) do
    primer_caracter=String.first(cadena)
    resto=String.slice(cadena,1..-1//1)

    if es_vocal?(primer_caracter) do
      1+contar_vocales(resto)
    else
      contar_vocales(resto)
    end
  end
  defp es_vocal?(letra), do: letra in ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

  def letra_inicio_fin_igual(productos) do
    Enum.filter(productos, fn {_codigo, producto} ->
      nombre = String.downcase(producto.nombre)
      String.first(nombre) == String.last(nombre) end)
      |>listar_productos()
  end

  def productos_valor_por_debajo(productos,referencia) do
    Enum.filter(productos, fn {_codigo, producto} -> producto.precio < referencia end)
      |>listar_productos()
  end

  def productos_mas_caros(productos) do
    Enum.sort_by(productos, fn {_codigo,producto} -> producto.precio  end,:desc)
      |>Enum.take(3)
      |>listar_productos()
  end

  def productos_rango(productos,min,max) do
    Enum.filter(productos, fn {_codigo,producto}-> producto.precio>=min and producto.precio <= max end)
      |>Enum.map(fn {_codigo,producto}-> "#{producto.nombre} - #{producto.precio}" end)
      |>Enum.join("\n")
  end

  def productos_rango_precios(productos) do
    Enum.group_by(productos, fn {_codigo,producto} ->
      cond do
      producto.precio < 50000 -> :menor_a_50000
      producto.precio <= 100.000 -> :entre_50000_y_100000
      true -> :mayor_a_100000
      end
    end)
  end
end
