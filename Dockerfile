FROM mcr.microsoft.com/dotnet/core/sdk:3.0.100-preview3 AS build
WORKDIR /app

COPY *.sln .
COPY Cloud64/*.csproj ./Cloud64/
RUN dotnet restore

COPY Cloud64/. ./Cloud64/

WORKDIR /app/Cloud64
RUN dotnet publish -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0.0-preview3 AS runtime
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "Cloud64.dll"]
EXPOSE 80
