# SwapiSwiftApp Star Wars
 
 ## Descripción:

Aplicación nativa iOS desarrollada con el API: https://swapi.dev/documentation

### **Tecnologías**:

 - SwiftUI, Combine.
 - Patrón de diseño MVVM.
 - User Defaults.
 - View Components.
 - XCTest Framework.

### **Compatibilidad**:

- iPhone & iPad.

 ### **Funcionalidades**:

 - Lista de planetas contenidos en el API. Cada planeta tiene los títulos de los films donde aparecieron.
 - Cuando se hace 'scroll' al final de la lista, se ejecuta un método que carga más planetas automáticamente.
 - Cada elemento de la lista es navegable a una vista Detalle del Planeta.
 - En la vista detalle del planeta se puede ver la información principal de cada planeta.
 - En la vista detalle del planeta también podemos ver un botón con la funcionalidad de añadir a favoritos el mismo. Así como también eliminarlo de favoritos.
 - Para almacenar los favoritos, utilizamos almacenamiento local. 'UserDefaults'.
 - Se crearon componentes visuales, que pueden perfectamente reutilizarse en otros módulos de la aplicación.
 - Se implementaron Tests Unitarios con el framework XCTest. En este caso, se probaron todos los métodos contenidos en nuestro **ViewModel: PlanetViewModel**.
 - Para las llamadas al API, utilizamos Combine.

 ### Los Unit Tests se encuentran en el siguiente archivo:

 - SwapiSwiftApp/PlanetViewModelTests.swift


 ### Referencias:

<img src="https://github.com/moradtfc/SwapiSwiftApp/assets/15786157/1c6e5ca3-a2f7-4ea0-bba7-b9ff72513c59" alt="" width="300px">
<img src="https://github.com/moradtfc/SwapiSwiftApp/assets/15786157/53215e38-5679-4f94-806a-6efd78840dc2" alt="" width="300px">



