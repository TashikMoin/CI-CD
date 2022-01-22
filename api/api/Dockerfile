# Get Base Image (Full .NET Core SDK)
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Copy csproj and restore
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Generate runtime image
FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENV PATH $PATH:/root/.dotnet/tools
RUN dotnet tool install --global dotnet-ef
ENV ASPNETCORE_URLS=http://+:80  
ENTRYPOINT ["dotnet", "api.dll"]