defmodule Menu do
  def main do
    {:ok, productos} = {:ok, %{}}

    mensaje=
    """

      Ingrese lo que desea hacer:
      (1) Crear un producto
      (2) Eliminar un producto
      (3) Actualizar un producto
      (4) Listar todos los productos
      (5) Listar productos con al menos 2 vocales
      (6) Listar productos que comienzan y terminan con la misma letra
      (7) Listar productos por debajo de un valor de referencia
      (8) Listar productos mas caros del inventario
      (9) Listar productos en un rango de precio
      (10) Agrupar productos por rango de precio
      (11) Salir

    """
    validar_menu_inicial(mensaje,productos)

  end

  def validar_menu_inicial(mensaje,productos) do
    opcion=Util.leer(mensaje,:integer)
    codigo=
      if opcion in [1,2,3] do
        Util.leer("Ingrese el código del producto: ", :string)
      else
        nil
      end
    case opcion do
      1 ->
        agregar=Inventario.agregar_producto(productos,codigo,
        Util.leer("Ingrese el nombre del producto a crear: ",:string),
        Util.leer("Ingrese el precio del producto a crear: ",:float),
        Util.leer("Ingrese la cantidad del producto: ", :integer))

        case agregar do
          {:error, razon} ->
            IO.puts("No se puede agregar: #{razon}")
            validar_menu_inicial(mensaje,productos)
          {:ok, productos_actualizados} ->
            IO.puts("Producto agregado")
            validar_menu_inicial(mensaje,productos_actualizados)
        end

      2 ->
        eliminar=Inventario.eliminar_producto(productos,codigo)
        case eliminar do
          {:error, :no_encontrado} ->
            IO.puts("No se pudo eliminar: código no encontrado")
            validar_menu_inicial(mensaje,productos)
          {:ok,productos_actualizados} ->
            IO.puts("Producto eliminado")
            validar_menu_inicial(mensaje,productos_actualizados)
        end

      3 ->
        actualizar=Inventario.actualizar_producto(productos, codigo,
        Util.leer("Ingrese el nombre del producto actualizado: ",:string),
        Util.leer("Ingrese el precio del producto actualizado: ",:float),
        Util.leer("Ingrese la cantidad del producto actualizada: ", :integer))
        case actualizar do
          {:error, :no_encontrado} ->
            IO.puts("No se pudo eliminar: código no encontrado")
            validar_menu_inicial(mensaje,productos)
          {:ok,productos_actualizados} ->
            IO.puts("Producto actualizado")
            validar_menu_inicial(mensaje,productos_actualizados)
        end

      4 ->
        IO.puts("\n=== Productos en el Inventario ===")
        Inventario.listar_productos(productos)

        validar_menu_inicial(mensaje,productos)

      5 ->
        IO.puts("Productos cuyo nombre contenga al menos dos vocales")
        IO.inspect(Inventario.productos_mas_2_vocales(productos))

        validar_menu_inicial(mensaje,productos)

      6 ->
        IO.puts("Productos cuyo nombre comience y termine con la misma letra")
        Inventario.letra_inicio_fin_igual(productos)

        validar_menu_inicial(mensaje,productos)

      7 ->
        IO.puts("Productos con precio por debajo de un valor dado")
        Inventario.productos_valor_por_debajo(productos,Util.leer("Ingrese el valor máximo de referencia: ",:float))

        validar_menu_inicial(mensaje,productos)

      8 ->
        IO.puts("Los tres productos más caros del inventario")
        Inventario.productos_mas_caros(productos)

        validar_menu_inicial(mensaje,productos)

      9 ->
        IO.puts("Productos con precio entre dos valores")
        IO.puts(Inventario.productos_rango(productos,
        Util.leer("Ingrese el valor mínimo del rango: ",:float),
        Util.leer("Ingrese el valor máximo del rango: ",:float)))

        validar_menu_inicial(mensaje,productos)

      10 ->
        IO.puts("Agrupar productos por rango de precio")
        IO.inspect(Inventario.productos_rango_precios(productos))

      11 ->
        IO.puts("Saliendo del programa...")

      _ ->
        IO.puts("Opción inválida")
        validar_menu_inicial(mensaje,productos)
    end
  end
end
