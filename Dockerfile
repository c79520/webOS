 FROM 
 version: '3.3'
services:
  db:
    image: mysql:5.7.4
    container_name: webos-mysql
    environment:
      - MYSQL_ROOT_PASSWORD=webos
      - MYSQL_DATABASE=webos  # 添加MYSQL_DATABASE环境变量
      - MYSQL_LOG_CONSOLE=true
    restart: always
    volumes:
      - ${PWD}/webos/db:/var/lib/mysql
    networks:
      - webos-net

  nginx:
    container_name: nginx
    image: nginx:1.22.0
    ports:
      - '80:80'
      - '8088:8088'
    volumes:
      - '${PWD}/webos/nginx/conf/nginx.conf:/etc/nginx/nginx.conf'
      - '${PWD}/webos/nginx/logs:/var/log/nginx'
      - '${PWD}/webos/nginx/html:/usr/share/nginx/html'
      - '${PWD}/webos/nginx/conf/conf.d:/etc/nginx/conf.d'
    networks:
      - webos-net

  onlyoffice:
    image: xiaohuochai/onlioffice:7.3.3
    container_name: onlyoffice
    privileged: true
    restart: always
    volumes:
      - '${PWD}/webos/onlyoffice/postgresql:/var/lib/postgresql'
      - '${PWD}/webos/onlyoffice/Data:/var/www/onlyoffice/Data'
      - '${PWD}/webos/onlyoffice/sdkjs-plugins:/var/www/onlyoffice/documentserver/sdkjs-plugins'
      - '${PWD}/webos/onlyoffice/onlyoffice:/var/lib/onlyoffice'
    environment:
      - JWT_ENABLED=false
    networks:
      - webos-net
  webos:
    container_name: webos
    volumes:
      - '${PWD}/webos/data:/webos/api/rootPath'
      - '${PWD}/webos/apps:/webos/web/apps'
    restart: always
    image: fs185085781/webos
    networks:
      - webos-net

networks:
  webos-net:
    driver: bridge
    
    EXPOSE 8088
    CMD docker-compose up -d
