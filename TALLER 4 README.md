# **EJECUCIÓN TALLER: STRUCTS, MAPAS Y MANEJO DE ARCHIVOS EN ELIXIR**

<p>
  Durante la ejecución del código se da aplicabilidad a los siguientes conceptos
  - Struct
  - Mapas (map)
  - Manejo de archivos (CSV y JSON)
  - Manejo de errores
</p>

## **GESTIÓN DE SOCIOS EN UN GIMNASIO**
<p>
  En el presente código se buscará gestionar los socios de un gimnasio, entiendase por socio a los usuarios
  que asisten al gimnasio, y los cuales deben tener algunos datos básicos como:
  - Cédula
  - Nombre
  - Edad
  - Lista de clases
</p>

### **FUNCIONALIDAD**
<p>
  El código para la ejecución del programa del gimnasio cuenta con un menu principal, el cual permite gestionar 
  la creación, eliminación del socio, además realizar la gestión de las clases a las que se puede inscribir, como se
  muestra a continuación:
  1. Crear un socio
  2. Eliminar un socio
  3. Inscribir a un socio en una clase
  4. Desinscribir a un socio de una clase
  5. Buscar un socio por cédula
  6. Listar todos los socios
  7. Listar todos los socios que estén inscritos en una clase específica
  8. Listar todas las clases de un socio dada su cédula
  9. Salir
</p>

## **SISTEMA DE INVENTARIO**
<p>
  El siguiente código presentedo es el sistema de inventario para una serie de productos que el usuario debe ingresar:
  - Código
  - Nombre
  - Precio
  - Cantidad
</p>
<p>
  Los datos se almacenan en formato tipo JSON, teniendo el id de cada producto como la llave de acceso a la demás información
</p>

### **FUNCIONALIDAD**
<p>
  El codigo tiene como finalidad principal poder:
  - Agregar producto
  - Actualizar producto
  - Eliminar producto
  - Listar producto

  Además de ello, se implementaron funciones utlizando Enum para los siguientes casos:
  1. Crear un producto
  2. Eliminar un producto
  3. Actualizar un producto
  4. Listar todos los productos
  5. Listar productos con almenos dos vocales
  6. Listar productos que comienzan y temrinan con la misma letra
  7. Listar productos por debajo de un valor de referencia
  8. Listar productos más caros del inventario
  9. Listar productos en un rango de precio
  10. Agrupar productos por rango de precio
  11. Salir
</p>

# **USO DE INTELIGENCIA ARTIFICAL EN EL DESARROLLO DE LA ACTIVIDAD**
<p>
  Para el desarrollo de esta tarea utilizamos inteligencia artificial como apoyo, sobre todo para entender mejor algunos errores que se nos presentaban 
  y cómo solucionarlos. Uno de los principales problemas que tuvimos fue con la inmutabilidad de los datos, ya que al inicio no estábamos retornando ni 
  usando el mapa actualizado cada vez que hacíamos un cambio, lo que hacía que la información no se guardara correctamente.
  También nos apoyamos para implementar validaciones, como el uso de Regex, para verificar que ciertos datos (como nombres) solo contuvieran letras, lo 
  cual nos ayudó a mejorar la entrada de datos y evitar errores.
  Por otro lado, reforzamos el manejo de la inmutabilidad en la conversión y manipulación de datos, entendiendo que cada operación debía devolver una 
  nueva estructura en lugar de modificar la existente.
  Además, en el caso de los datos en JSON, buscamos cómo se codificaban correctamente para poder guardarlos y también cómo leerlos después, ya que al
  principio tuvimos inconvenientes con ese proceso.
  
</p>

# **APRENDIZAJES OBTENIDOS EN EL DESARROLLO DE LA ACTIVIDAD**
<p>
  En conclusión, con este trabajo logramos entender mucho mejor cómo funciona la inmutabilidad y por qué es tan importante al momento de programar, 
  especialmente en lenguajes como elixir. Aprendimos que no basta con hacer cambios, sino que siempre hay que retornar y trabajar con las estructuras 
  actualizadas para que todo funcione correctamente.
  También reforzamos el uso de validaciones, como las expresiones regulares, para controlar mejor los datos de entrada, y comprendimos cómo manejar 
  información en formato JSON, tanto para guardarla como para leerla sin errores.
  
</p>
