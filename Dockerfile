FROM mcr.microsoft.com/dotnet/core/sdk as build
ARG BUILDCONFIG=RELEASE
ARG VERSION=1.0.0

COPY aspnet.csproj /build/

RUN dotnet restore ./build/aspnet.csproj

COPY . ./build/
WORKDIR /build/
RUN  dotnet publish ./aspnet.csproj -c $BUILDCONFIG -o out /p:Version=$VERSION

FROM mcr.microsoft.com/dotnet/core/aspnet
WORKDIR /app

COPY --from=build /build/out .

ENTRYPOINT [ "dotnet","aspnet.dll" ]