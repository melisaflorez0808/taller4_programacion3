defmodule Menu do
  def main do
    {:ok, socios} = {:ok,Gimnasio.inicializar()}

    mensaje=
    """

      Ingrese lo que desea hacer:
      (1) Crear un socio
      (2) Eliminar un socio
      (3) Inscribir un socio a una clase
      (4) Desinscribir a un socio de una clase
      (5) Buscar un socio por cédula
      (6) Listar todos los socios
      (7) Listar todos los socios que estén inscritos en una clase específica
      (8) Listar todas las clases de un socio dada su cédula
      (9) Salir

    """
    validar_menu_inicial(mensaje,socios)

  end

   def validar_menu_inicial(mensaje,socios) do
    opcion=Util.leer(mensaje,:integer)
    cedula=
      if opcion in [1,2,3,4,5,8] do
        Util.leer("Ingrese la cédula del socio: ", :string)
      else
        nil
      end
    case opcion do
      1 ->
        agregar=Gimnasio.agregar_socio(socios,cedula,
        Util.leer("Ingrese el nombre del socio a crear: ",:string),
        Util.leer("Ingrese la edad del socio a crear: ",:integer))

        case agregar do
          {:error, razon} ->
            IO.puts("No se puede agregar: #{razon}")
            validar_menu_inicial(mensaje,socios)
          {:ok, socios_actualizados} ->
            IO.puts("Socio agregado")
            validar_menu_inicial(mensaje,socios_actualizados)
        end

      2 ->
        eliminar=Gimnasio.eliminar_socio(socios,cedula)
        case eliminar do
          {:error, :no_encontrado} ->
            IO.puts("No se pudo eliminar: cedula no encontrada")
            validar_menu_inicial(mensaje,socios)
          {:ok,socios_actualizados} ->
            IO.puts("Socio eliminado")
            validar_menu_inicial(mensaje,socios_actualizados)
        end

      3 ->
        inscribir=Gimnasio.inscribir_clase(socios,cedula,
        Util.leer("Ingrese la clase a la que desea registrar al socio: ",:string))

        case inscribir do
          {:error, :no_encontrado} ->
            IO.puts("Socio no encontrado")
            validar_menu_inicial(mensaje,socios)
          {:error, :ya_inscrito} ->
            IO.puts("Ya está inscrito en esa clase")
            validar_menu_inicial(mensaje,socios)
          {:ok, socios_actualizados} ->
            IO.puts("Inscrito en clase")
            validar_menu_inicial(mensaje,socios_actualizados)
        end

      4 ->
        desinscribir=Gimnasio.desinscribir_clase(socios,cedula,
        Util.leer("Ingrese la clase a la que desea desinscribir al socio: ",:string))

        case desinscribir do
          {:error, :no_encontrado} ->
            IO.puts("Socio no encontrado")
            validar_menu_inicial(mensaje,socios)
          {:error, _} ->
            IO.puts("El socio no está inscrito en esa clase")
            validar_menu_inicial(mensaje,socios)
          {:ok, socios_actualizados} ->
            IO.puts("Se desinscribió el socio correctamente de la clase")
            validar_menu_inicial(mensaje,socios_actualizados)
        end

      5 ->
        socio=Gimnasio.obtener_socio(socios,cedula)

        case socio do
          {:ok, socio} ->
            IO.puts("\n=== Socio ===")
            IO.inspect(socio)
          {:error, _} ->
            IO.puts("Socio no encontrado")
        end

        validar_menu_inicial(mensaje,socios)

      6 ->
        IO.puts("\n=== Socios Inscritos ===")
        Gimnasio.listar_socios(socios)

        validar_menu_inicial(mensaje,socios)

      7 ->
        clase=Util.leer("Ingrese la clase sobre la que desea validar los clientes inscritos: ",:string)
        IO.puts("\n=== Socios Inscritos al curso #{clase} ===")
        Gimnasio.socios_en_clase(socios,clase)

        validar_menu_inicial(mensaje,socios)

      8 ->
        socio=Gimnasio.obtener_socio(socios,cedula)
        case socio do
          {:ok, socio} ->
            IO.puts("\n=== Socio #{socio.nombre}===")
            if (socio.clases==[]) do
              IO.puts("El socio no tiene clases inscritas")
            else
              IO.puts(Enum.join(socio.clases, "\n"))
            end
          {:error, _} ->
            IO.puts("Socio no encontrado")
        end

        validar_menu_inicial(mensaje,socios)

      9 ->
        IO.puts("Saliendo del programa...")

      _ ->
        IO.puts("Opción inválida")
        validar_menu_inicial(mensaje,socios)
    end
  end
end
