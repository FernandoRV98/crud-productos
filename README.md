# CRUD de Productos

API REST para la gestión de productos desarrollada con **ASP.NET Core .NET 8**, **Entity Framework Core** y **SQL Server**.

El proyecto permite realizar las operaciones básicas de un CRUD: consultar, crear, actualizar y eliminar productos.

El frontend del proyecto fue desarrollado por separado utilizando Angular.

## Tecnologías utilizadas

- .NET 8
- ASP.NET Core Web API
- Entity Framework Core 8
- SQL Server 2022
- Docker
- GitHub Codespaces
- Swagger / OpenAPI

## Arquitectura

La aplicación utiliza una arquitectura cliente-servidor.

```text
Angular
   │
   │ HTTP / REST
   ▼
ASP.NET Core Web API
   │
   │ Entity Framework Core
   ▼
SQL Server 2022
```

El frontend consume los endpoints proporcionados por la API.

La API utiliza Entity Framework Core para comunicarse con la base de datos SQL Server.

## Funcionalidades

La API permite:

- Consultar todos los productos.
- Consultar un producto por su ID.
- Crear nuevos productos.
- Actualizar productos existentes.
- Eliminar productos.

## Modelo de Producto

Los productos manejan la siguiente información:

| Campo | Tipo | Descripción |
|---|---|---|
| Id | int | Identificador único del producto |
| Nombre | string | Nombre del producto |
| Precio | decimal | Precio del producto |
| Stock | int | Cantidad disponible |

## Endpoints

La API utiliza la ruta base:

```text
/api/productos
```

| Método | Endpoint | Descripción |
|---|---|---|
| GET | `/api/productos` | Obtiene todos los productos |
| GET | `/api/productos/{id}` | Obtiene un producto por ID |
| POST | `/api/productos` | Crea un nuevo producto |
| PUT | `/api/productos/{id}` | Actualiza un producto |
| DELETE | `/api/productos/{id}` | Elimina un producto |

### Ejemplo de producto

```json
{
  "id": 1,
  "nombre": "Teclado mecánico",
  "precio": 1299.90,
  "stock": 10
}
```

## Base de datos

El proyecto utiliza **SQL Server 2022** ejecutándose dentro de un contenedor Docker.

La base de datos utilizada es:

```text
CrudProductosDb
```

La tabla principal es:

```text
Productos
```

El repositorio incluye el script:

```text
database/init.sql
```

Este script crea la base de datos, la tabla `Productos` y agrega datos iniciales para realizar pruebas.

### Datos iniciales

| Id | Nombre | Precio | Stock |
|---|---|---:|---:|
| 1 | Teclado mecánico | 1299.90 | 10 |
| 2 | Mouse inalámbrico | 549.50 | 25 |
| 3 | Monitor 24 pulgadas | 3299.00 | 7 |

## Configuración de SQL Server

Durante el desarrollo, SQL Server se ejecutó mediante Docker.

Ejemplo para crear el contenedor:

```bash
docker run \
  -e "ACCEPT_EULA=Y" \
  -e "MSSQL_SA_PASSWORD=<TU_PASSWORD>" \
  -p 1433:1433 \
  --name sql-productos \
  --hostname sql-productos \
  -v sql-productos-data:/var/opt/mssql \
  -d \
  mcr.microsoft.com/mssql/server:2022-latest
```

> La contraseña mostrada en la configuración debe sustituirse por una contraseña propia y no debe almacenarse en el repositorio.

Si el contenedor ya existe pero se encuentra detenido:

```bash
docker start sql-productos
```

## Configuración de la conexión

La cadena de conexión puede configurarse utilizando **.NET User Secrets**, evitando almacenar credenciales directamente en el repositorio.

Inicializar User Secrets:

```bash
dotnet user-secrets init
```

Después se puede configurar la cadena de conexión correspondiente al entorno local.

## Ejecutar la API

Entrar al proyecto backend:

```bash
cd Backend
```

Restaurar las dependencias:

```bash
dotnet restore
```

Compilar el proyecto:

```bash
dotnet build
```

Ejecutar la API:

```bash
dotnet run --urls "http://0.0.0.0:5000"
```

La API estará disponible en:

```text
http://localhost:5000
```

Por ejemplo:

```text
http://localhost:5000/api/productos
```

## Estructura del proyecto

```text
crud-productos/
│
├── .devcontainer/
│   └── devcontainer.json
│
├── Backend/
│   ├── Controllers/
│   │   └── ProductosController.cs
│   │
│   ├── Data/
│   │   └── AppDbContext.cs
│   │
│   ├── Models/
│   │   └── Producto.cs
│   │
│   ├── Program.cs
│   └── Backend.csproj
│
├── database/
│   └── init.sql
│
├── .gitignore
└── README.md
```

## Frontend

El frontend fue desarrollado utilizando **Angular** y consume esta API mediante `HttpClient`.

Se encuentra en un repositorio independiente:

`crud-productos-frontend`

El frontend implementa las operaciones de:

- Listar productos.
- Crear productos.
- Editar productos.
- Eliminar productos.

## Pruebas realizadas

Durante el desarrollo se comprobaron las operaciones CRUD completas entre las tres capas:

```text
Angular              ASP.NET Core            SQL Server

GET      ──────────► GET      ─────────────► SELECT
POST     ──────────► POST     ─────────────► INSERT
PUT      ──────────► PUT      ─────────────► UPDATE
DELETE   ──────────► DELETE   ─────────────► DELETE
```

También se comprobó que los cambios permanecieran almacenados en SQL Server después de actualizar el frontend.

## Autor

**Jose Fernando Ruiz Vargas**