# DodontoF-Docker
Dockerfile for [DodontoF](http://www.dodontof.com/)

## Usage
1. Build Docker Image
  ```sh
  git clone https://github.com/ukatama/DodontoF-Docker.git
  docker build -t dodontof DodontoF-Docker
  ```

2. Make data directories
  ```sh
  wget http://www.dodontof.com/DodontoF/DodontoF_Ver.1.47.20.zip
  unzip DodontoF_Ver.1.47.17.zip
  cp -r DodontoF_WebSet/saveData <path/to/saveData>
  cp -r DodontoF_WebSet/public_html/imageUploadSpace <path/to/imageUploadSpace>
  chown -R www-data:www-data <path/to/saveData>
  chown -R www-data:www-data <path/to/imageUploadSpace>
  ```

3. Run Docker Container
  ```sh
  docker run -d -p 80:80 \
    -v <path/to/saveData>:/usr/local/src/DodontoF_WebSet/saveData \
    -v <path/to/imageUploadSpace>:/usr/local/src/DodontoF_WebSet/public_html/imageUploadSpace \
    --name dodontof \
    dodontof
```
