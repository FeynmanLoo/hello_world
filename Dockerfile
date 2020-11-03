FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./aspnetapp/
RUN dotnet restore

# copy everything else and build app
COPY aspnetapp/. ./aspnetapp/
WORKDIR /app/aspnetapp
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
COPY --from=build /app/aspnetapp/out ./
EXPOSE 80
ENTRYPOINT ["dotnet", "hello_world.dll"]
