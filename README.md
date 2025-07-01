
# docker-lamp

Proyecto Docker LAMP que incluye:

- PHP 8.4 con Apache y extensiones comunes (pdo, mysqli, zip, gd, xml, mbstring)
- MySQL 8
- phpMyAdmin
- SSH habilitado (usuario root / sin contraseña)
- SSL con certificado autofirmado (HTTPS)
- Composer instalado
- Carpeta `html` externa para desarrollo web

---

## Autor

**Domingo Ruiz Arroyo**  
Correo: ordenadordomi@gmail.com  
GitHub: [https://github.com/domingoruiz/docker-lamp](https://github.com/domingoruiz/docker-lamp)

---

## Contenido

Este proyecto contiene:

- `Dockerfile`: imagen PHP 8.4 con Apache, SSH, Composer y módulos PHP típicos  
- `docker-compose.yml`: orquestación de servicios (web, MySQL, phpMyAdmin)  
- Configuración SSL con certificado autofirmado  
- Carpeta `html/` externa para servir contenido web  
- Configuración Apache SSL en `apache/default-ssl.conf`  

---

## Requisitos

- Docker y Docker Compose instalados
- OpenSSL (para generar certificados)  

---

## Uso

1. Clona el repositorio:

```bash
git clone https://github.com/domingoruiz/docker-lamp.git
cd docker-lamp
```

2. Genera el certificado SSL autofirmado (si no existe):

```bash
mkdir -p ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ssl/server.key -out ssl/server.crt \
  -subj "/C=ES/ST=Málaga/L=ESP/O=Dev/CN=localhost"
```

3. Levanta los contenedores:

```bash
docker-compose up -d --build
```

---

## Accesos

| Servicio     | Dirección                             |
|--------------|-------------------------------------|
| Web HTTP     | http://localhost                    |
| Web HTTPS    | https://localhost (certificado autofirmado) |
| phpMyAdmin   | http://localhost:8080               |
| SSH          | ssh root@localhost -p 2222 (clave: root) |
| MySQL        | localhost:3306 (user/pass: user)   |

---

## Notas

- El contenedor web expone puertos 80, 443 (SSL) y 2222 (SSH).  
- El volumen `html` permite editar el contenido fuera del contenedor.  
- Se usa `platform: linux/arm64` en Docker Compose para compatibilidad con Mac ARM.  
- Apache y SSH se inician automáticamente en el contenedor web.  
- Composer está instalado y listo para usar dentro del contenedor.