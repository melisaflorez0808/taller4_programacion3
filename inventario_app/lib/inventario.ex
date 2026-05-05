defmodule Inventario do

  def agregar_producto(productos, codigo, nombre, precio, cantidad) do
    case Producto.nuevo(nombre,precio,cantidad) do
      {:ok, nuevo_producto} ->
        cond do
          Map.has_key?(productos, codigo) ->
            {:error, :codigo_repetido}
          String.length(codigo)<=5 ->
            {:error, :codigo_invalido}
          true ->
            {:ok, Map.put(productos,codigo,nuevo_producto)}
        end
      {:error, razon} ->
        {:error, razon}
    end
  end

  def eliminar_producto(productos, codigo) do
    if Map.has_key?(productos, codigo) do
      {:ok, Map.delete(productos, codigo)}
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
        {:ok, Map.put(productos,codigo,actualizado)}
    end
  end

  def listar_productos(productos) when map_size(productos)==0, do: IO.puts("No hay productos inscritos en el inventario")

  def listar_productos(productos) do
    Enum.each(productos, fn{codigo, producto} -> IO.puts("Codigo: #{codigo} Nombre: #{producto.nombre}, Precio #{producto.precio}, Cantidad #{producto.cantidad}") end)
  end

end

"""
Productos cuyo nombre contenga al menos dos vocales. Retornar una lista de tuplas: [{codigo, nombre}]
Productos cuyo nombre comience y termine con la misma letra
Productos con precio por debajo de un valor dado
Los tres productos más caros del inventario
Productos con precio entre dos valores Retornar una cadena: "Producto1 - 50000, Producto2 - 70000"
Agrupar productos por rango de precio:
Menores a 50000
Entre 50000 y 100000
Mayores a 100000

"""
