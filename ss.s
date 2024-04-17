name: Python Docker image

on:
  workflow_dispatch:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-push-image:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Build Docker image
      run: |
        docker build -t my-image .
    - name: Log in to Docker Hub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}
    - name: Tag and push Docker image
      run: |
        docker tag my-image ${{ secrets.DOCKER_USERNAME }}/my-image:${{ github.sha }}
        docker push ${{ secrets.DOCKER_USERNAME }}/my-image:${{ github.sha }}
